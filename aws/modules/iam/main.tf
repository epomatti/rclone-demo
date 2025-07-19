resource "aws_iam_user" "rcloud" {
  name          = "rcloud"
  path          = "/rcloud/"
  force_destroy = true
}

resource "aws_iam_access_key" "rcloud" {
  user = aws_iam_user.rcloud.name
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
          "${var.bucket_arn}/*",
          "${var.bucket_arn}"
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
  name       = "RcloudPolicyAttachment"
  users      = [aws_iam_user.rcloud.name]
  policy_arn = aws_iam_policy.rcloud.arn
}
