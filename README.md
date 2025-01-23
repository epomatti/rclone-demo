# aws-rclone-demo


```sh
cp config/local.auto.tfvars .auto.tfvars
```

```sh
/root/.config/rclone/rclone.conf
```

```sh
bash scripts/ssm-get-secret.sh
```

```sh
rclone copy hello.txt remote:hello.txt
```

```
rclone listremotes --long
rclone config delete mys3
```

```sh
rclone config create mys3 s3 \
  provider AWS \
  access_key_id YOUR_ACCESS_KEY_ID \
  secret_access_key YOUR_SECRET_ACCESS_KEY \
  region us-east-2 \
  endpoint https://s3.amazonaws.com \
  storage_class STANDARD
```

```
aws configure
```

```sh
aws s3api put-object \
    --bucket amzn-s3-demo-bucket \
    --key my-dir/MySampleImage.png \
    --body MySampleImage.png
```

rclone lsd mys3:
rclone config show
rclone ls mys3:my-bucket/folder/subfolder
rclone copy /path/to/your/file.txt mys3:your-bucket-name --no-create
rclone sync /local/folder mys3:your-bucket-name --no-create
