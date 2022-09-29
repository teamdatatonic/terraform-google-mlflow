# Terraform Google Mlflow

This module deploys the necessary infrastructure for an mlflow tracking server running through the cloud run service that requires IAP to access.

## Mlflow Configuration.
Mlflow logs parameters, metrics, artifacts and the trained model itself, in this case the parameters and metrics are stored in a database running in GCP's SQL instance and the artifacts and model are logged in a GCS bucket. As shown in the figure below.

![mlflow_config](/assets/mlflow.png)

* Part 1a and 1b (blue arrows):
    * The Mlflow client sends REST API requests to log Mlflow entities. (1a)
    * The Tracking Server connects to the remote host for inserting tracking information in the database i.e parameters, metrics, tags. (1b)

* part 1c and 1d (brown arrows):
    * Retrival request by the client return information from the database

*  Part 2a and 2b (pink arrows):
    * Logging events for artifacts are made by the client to write files to the Mlflow Tracking Server. (2a)
    * The Tracking Server then writes these files to the configured object store location with the assumed role authentication. (2b)

* Part 2c and 2d (black arrows):
    * Retrieving artifacts from the configured backend store for a user request is done with the same authorized authentication that was configured at server start. (2d)
    * Artifacts are passed to the end user through the Tracking Server. (2c)

## GCP Architecture.

![Architecture](/assets/GCP_Arch.png)

## Usage.
You can go to the examples folder for module usage, the usage of the resource modules could be like this in your own main.tf file:

```hcl

module "mlflow" {
  source = "teamdatatonic/mlflow/google"
  version = "1.2.0"

  project_id = "mlflow-gcp"
  region = 'europe-west2'
  zone = 'europe-west2-a'
  mlflow_docker_image = 'europe-docker.pkg.dev/mlflow-gcp/mlflow:latest'
  brand_name = 'straw_hats'
  support_email = 'support@email.com'
  oauth_client_id = '977178309684-7gcg621ahtq39p03mh55q65p88906.apps.googleusercontent.com'
  oauth_client_secret = 'MOKLPX-C-QuBFCAmgUtYkXTSzQQBzU7YHXq'
  domain = 'mlflow.domain.com'
  webapp_users = 'user:dev1@email.com, user:dev2@email.com'
}

```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0|
| google | ~>  4.9.0 |
| google-beta | ~>  4.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mlflow"></a> [mlflow](#module\_mlflow) | ./modules/mlflow | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_services"></a> [services](#module\_services) | ./modules/services | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.artifacts_bucket_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project name you want to enable the services for. | `string` | n/a | yes |
| region | The Google Cloud region in which to provision the resources. | `string` | n/a | yes |
| zone | The Google Cloud zone in which to provision the resources. | `string` | n/a | yes |
| mlflow\_docker\_image | Name of the docker image containing the mlflow server. | `string` | n/a | yes |
| network\_name | if you have a prefered network to use enter it if not leave it empty one will be created for you. | `string` | n/a | no |
| storage\_uniform | Uniform access level to be activated for the buckets | `string` | n/a | no |
| brand\_name | if the create_band input is 0 (if it exists) enter the name of the brand | `string` | n/a | no |
| support\_email | Person or group to contact in case of problems | `string`| n/a | yes |
| oauth\_client\_id | if the create_band input is 0 (if it exists) enter the name of the Oauth Client Id | `string` | n/a | no |
| oauth\_client\_secret | if the create_band input is 0 (if it exists) enter the OAuth Client Secret for the Oauth Client Id entered above | `string` | n/a | no |
| lb\_name | Name of the load balancer | `string` | `"mlflow-lb"` | no |
| domain | The domain name that is configured to point to the load balancer IP address | `string` | n/a | yes |
| webapp\_users | The list of users who can access the mlflow tracking server from the domain (webpage) | `list(string)` | n/a | yes |


## Outputs

| Name | Description |
|------|-------------|
| lb\_ip | The load balancer's IP address that your domain / subdomain should point to |
| oauth\_redirect\_url | The Oauthentication redirect url that you add to the you OAuth 2.0 Client ID's list of authorized urls |
| brand\_name | The brand name created by Terraform for you (if you didn't enter any brand name in the Inputs) |
