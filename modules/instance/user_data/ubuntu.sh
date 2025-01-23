#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt update
apt upgrade -y

sudo apt install -y rclone rsync cron
