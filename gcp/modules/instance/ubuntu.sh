#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt update
apt upgrade -y

apt install -y rsync cron zip unzip jq

### Install rclone
# https://rclone.org/install/#linux

# Fetch and unpack
# curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
# unzip rclone-current-linux-amd64.zip
# cd rclone-*-linux-amd64

# # Copy binary file
# cp rclone /usr/bin/
# chown root:root /usr/bin/rclone
# chmod 755 /usr/bin/rclone

# Install manpage
# mkdir -p /usr/local/share/man/man1
# cp rclone.1 /usr/local/share/man/man1/
# mandb
