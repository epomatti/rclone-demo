# Rclone Demo on AWS

Setting up an environment on AWS to up sync files with S3.

## AWS

### Deploy

Create the variables file:

```sh
cp config/local.auto.tfvars .auto.tfvars
```

Deploy the infrastructure:

> [!TIP]
> Setting `ec2_auto_config_rclone = true` will config rclone via cloud-init

```sh
terraform init
terraform apply -auto-approve
```

Log into the EC2 instance, and the check for the `cloud-init status`.

### Config

To configure rclone manually, get the access key information:

```sh
bash scripts/ssm-get-secret.sh
```

Create the rclone configuration:

```sh
rclone config create mys3 s3 \
  provider AWS \
  access_key_id "$ACCESS_KEY_ID" \
  secret_access_key "$ACCESS_KEY_SECRET" \
  region us-east-2
```

### Testing

Verify that rclone is configured:

```
rclone listremotes --long
rclone lsd mys3:
rclone config show
```

Default configuration file should be located here:

```sh
/root/.config/rclone/rclone.conf
```

Create a local test file in the EC2 instance:

```sh
echo "Hello" > hello.txt
```

Copy the file to via rclone to S3:

```sh
rclone copy hello.txt "mys3:$BUCKET" --s3-no-check-bucket
```

Check the remote copy:

```sh
rclone ls mys3:$BUCKET/hello.txt
```

Try with the `sync` command:

```sh
rclone sync hello.txt "mys3:$BUCKET" --s3-no-check-bucket
```

## GCP

### Deploy

Login to GCP:

```sh
gcloud auth login
```

Create the variables file:

```sh
cp config/local.auto.tfvars .auto.tfvars
```

Check for updated images:

```sh
gcloud compute images list --project=ubuntu-os-cloud --no-standard-images --filter="name~'2404'"
```

Set the required variables.

Create the infrastructure:

```sh
terraform init
terraform apply -auto-approve
```

Permissions will be `roles/storage.objectCreator`. Check the bucket policy - not IAM - to confirm the permissions:

```sh
gsutil iam get gs://your-bucket
```

### Configure Rclone

Create the service account key file with the name `service_account_key.json`.

```sh
gcloud iam service-accounts keys create ~/service_account_key.json \
  --iam-account my-service-account@my-project.iam.gserviceaccount.com
```



```sh
rclone config create mygcs gcs \
  service_account_file service_account_key.json
```

### Testing

Verify that rclone is configured:

```sh
rclone listremotes --long
rclone lsd mygcs:
rclone config show
```

Default configuration file should be located here:

```sh
/root/.config/rclone/rclone.conf
```

Create a local test file in the EC2 instance:

```sh
echo "Hello" > hello.txt
```

Copy the file to via rclone to S3:

```sh
rclone copy hello.txt "mygcs:$BUCKET" --no-traverse --ignore-existing --log-level INFO
```

Check the remote copy:

```sh
rclone ls mys3:$BUCKET/hello.txt
```

Try with the `sync` command:

```sh
rclone sync hello.txt "mys3:$BUCKET" --s3-no-check-bucket

rclone rcat gcs:your-bucket-name/hello.txt < hello.txt
```

```sh
cat hello.txt | rclone rcat gcs:your-bucket-name/hello.txt
```

```toml
[mygcs]
type = gcs
service_account_file = service_account_key.json
no_check_bucket = true
```

--no-check-dest


--gcs-bucket-policy-only

--gcs-no-acl







rclone copy hello.txt "mygcs:rclone-bucket-nodal-algebra-355718" --gcs-bucket-policy-only --ignore-existing
rclone copy hello.txt "mygcs:rclone-bucket-nodal-algebra-355718" --gcs-bucket-policy-only --ignore-existing --no-check-dest
