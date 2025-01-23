#!/bin/bash

aws ssm get-parameter --name "/rcloud/access_key" --with-decryption --query Parameter.Value --output text | jq
