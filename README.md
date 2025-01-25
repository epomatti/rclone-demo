# Rclone Demo on AWS

Setting up an environment on AWS to up sync files with S3.

## Deploy

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

## Config

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

## Testing

Verify that rclone is configured:

```
rclone listremotes --long
rclone lsd mys3:
rclone config show
```

Default configuration fie should be located here:

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
