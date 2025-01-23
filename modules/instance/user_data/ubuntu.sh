#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt update
apt upgrade -y

sudo apt install -y rclone rsync cron


### Fro troubleshooting ###
# sudo apt install -y zip unzip
# curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# ./aws/install
