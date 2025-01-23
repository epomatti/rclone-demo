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
aws configure
```

```sh
aws s3api put-object \
    --bucket amzn-s3-demo-bucket \
    --key my-dir/MySampleImage.png \
    --body MySampleImage.png
```