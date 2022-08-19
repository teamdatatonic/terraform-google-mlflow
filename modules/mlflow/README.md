# Mlflow Module

Deploys the necessary infrastructure required to successfully run a mlflow tracking server container on GCP's cloud run

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0|
| google | ~>  4.9.0 |
| google-beta | ~>  4.9.0 |

## Providers

No provider

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project name you want to enable the services for. | `string` | n/a | yes |
| region | The Google Cloud region in which to provision the resources. | `string` | n/a | yes |
| zone | The Google Cloud zone in which to provision the resources. | `string` | n/a | yes |
| docker\_image\_name | The docker image containing the mlflow server. | `string` | n/a | yes |
| artifacts\_bucket\_name | Name of the bucket to store artifacts | `string` | n/a | yes |
| artifacts\_bucket\_location | Location of the bucket to store artifacts in | `string` | `"europe-west2"` | no |
| artifacts\_number\_version | number of file versions kept in the bucket | `number` | `1` | no |
| artifacts\_storage\_class | Storage class of the artifacts bucket | `string` | `"STANDARD"` | no |
| db\_instance\_prefix | prefix of the database instance you want to create | `string` | `"mlflow"` | no |
| db\_name | The name of the database instance to create. | `string` | `"mlflow-db"` | no |
| db\_version | Database SQL instance version to create. | `string` | `"POSTGRES_13"` | no |
| db\_region | The Google Cloud region in which to provision the database. | `string` | `"europe-west2"` | no |
| db\_tier | The size of the database instance to create. | `string` | `"db-f1-micro"` | no |
| db\_availability\_type | The type of availability for the database instance. | `string` | `"ZONAL"` | no |
| db\_username | The username for the database created. | `string` | `"mlflowuser"` | no |
| db\_password\_secret\_name | The secret name of the password for the database created. | `string` | `"mlflow-db-pwd"` | no |
| network\_self\_link | The self link of the network to use for the database instance. | `string` | n/a | yes |
| network\_short\_name | The short name of the network to use for the database instance. | `string` | n/a | yes |
| create\_brand | Creates a brand for Oauth the consent screen, 1 if the brand needs to be created, 0 otherwise | `number` | n/a | yes |
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
| load\_balancer\_ip | The load balancer's IP address that your domain / subdomain should point to |
| oauth\_redirect\_url | The Oauthentication redirect url that you add to the you OAuth 2.0 Client ID's list of authorized urls |
| created\_brand\_name | The brand name created by Terraform for you (if you didn't enter any brand name in the Inputs) |
