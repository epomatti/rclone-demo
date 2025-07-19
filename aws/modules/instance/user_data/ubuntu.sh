#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt update
apt upgrade -y

sudo apt install -y rclone rsync cron zip unzip jq

# Install AWS CLI
apt install -y zip unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Setup rclone
configRclone=$(aws ssm get-parameter --name "/rcloud/auto-config" --query Parameter.Value --output text)

if [ "$configRclone" == "true" ]; then

  accessKey=$(aws ssm get-parameter --name "/rcloud/access-key" --with-decryption --query Parameter.Value --output text | jq)

  accessKeyId=$(echo $accessKey | jq ".id" --raw-output)
  accessKeySecret=$(echo $accessKey | jq ".secret" --raw-output)

  TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
  EC2_REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/region)
  
  rclone config create mys3 s3 \
    provider AWS \
    access_key_id "$accessKeyId" \
    secret_access_key "$accessKeySecret" \
    region "$EC2_REGION"
fi
