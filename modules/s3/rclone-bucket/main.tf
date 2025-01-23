locals {
  random_affix = random_string.random_suffix.result
}

resource "random_string" "random_suffix" {
  length  = 3
  special = false
  upper   = false
}

resource "aws_s3_bucket" "main" {
  bucket        = "bucket-${var.workload}-${local.random_affix}"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_iam_user" "rcloud" {
  name          = "rcloud"
  path          = "/rcloud/"
  force_destroy = true
}

resource "aws_iam_access_key" "rcloud" {
  user = aws_iam_user.rcloud.name
}

resource "aws_ssm_parameter" "rcloud" {
  name = "/rcloud/access_key"
  type = "SecureString"

  value = jsonencode({
    "access_key" : "${aws_iam_access_key.rcloud.id}",
    "secret_key" : "${aws_iam_access_key.rcloud.secret}"
  })
}

resource "aws_iam_policy" "rcloud" {
  name = "RCloudPolicy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket",
          "s3:ListBuckets",
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl",
        ],
        "Resource" : [
          "${aws_s3_bucket.main.arn}/*",
          "${aws_s3_bucket.main.arn}"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListAllMyBuckets"
        ],
        "Resource" : [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "rcloud" {
  name  = "RcloudPolicyAttachment"
  users = [aws_iam_user.rcloud.name]
  # roles      = [aws_iam_role.role.name]
  # groups     = [aws_iam_group.group.name]
  policy_arn = aws_iam_policy.rcloud.arn
}

# resource "aws_iam_group_policy_attachment" "rcloud" {
#   group      = aws_iam_group.rcloud.name
#   policy_arn = aws_iam_policy.rcloud.arn
# }



# Minimum permissions according to rclone documentation
# resource "aws_s3_bucket_policy" "default" {
#   bucket = aws_s3_bucket.main.id

#   policy = jsonencode({
#     "Version" : "2008-10-17",
#     "Id" : "AllowOperationsWithBucket",
#     "Statement" : [
#       {
#         "Sid" : "OperationsWithBucket",
#         "Effect" : "Allow",
#         "Principal" : { "AWS" : [
#           "${aws_iam_user.rcloud.arn}"
#           ]
#         },
#         "Action" : [
#           "s3:ListBucket",
#           "s3:ListBuckets",
#           "s3:DeleteObject",
#           "s3:GetObject",
#           "s3:PutObject",
#         ],
#         "Resource" : [
#           "${aws_s3_bucket.main.arn}/*",
#           "${aws_s3_bucket.main.arn}"
#         ]
#       }
#     ]
#   })
# }

# TODO: Removed for now
# {
#   "Effect" : "Allow",
#   "Action" : "s3:ListAllMyBuckets",
#   "Resource" : "arn:aws:s3:::*"
# }

