# Google Cloud

## Deployment

Login to GCP:

```sh
# General Access
gcloud auth login

# Terraform
gcloud auth application-default login
```

Create the variables file:

```sh
cp config/default.tfvars .auto.tfvars
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

Connect to the virtual machine:

```sh
# For increased AIP tunnel performance
# https://docs.cloud.google.com/iap/docs/using-tcp-forwarding#increasing_the_tcp_upload_bandwidth
$(gcloud info --format="value(basic.python_location)") -m pip install numpy

# Connect to the instance
gcloud compute ssh rclone-instance --zone=southamerica-east1-a --tunnel-through-iap --project <project>
```

Creck the permissions:

```sh
gsutil iam get gs://your-bucket
```

## RCLONE

### Setup

Create a key:

```sh
gcloud iam service-accounts keys create "$HOME/key.json" \
  --iam-account rclone-service-account@<PROJECT_ID>.iam.gserviceaccount.com
```

Initialize the configuration with the account key file:

```sh
rclone config create mygcs gcs \
  service_account_file "$HOME/key.json" project_number="your-gcp-project-id" no_check_bucket true
```
