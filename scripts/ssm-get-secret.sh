#!/bin/bash

aws ssm get-parameter --name "/rcloud/access-key" --with-decryption --query Parameter.Value --output text | jq -r "."
