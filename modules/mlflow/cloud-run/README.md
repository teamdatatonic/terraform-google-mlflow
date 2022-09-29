# Cloud-Run Module

Configures the load balancer in order to have IAP enabled and contains the cloud run services that runs the mlflow tracking server

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
| docker\_image\_name | The docker image containing the mlflow server. | `string` | n/a | yes |
| db\_instance | Name of the database instance containing the DB | `string` | n/a | yes |
| db\_name | The name of the database instance to connect to. | `string` | n/a | yes |
| db\_username | The username for the database to connect to. | `string` | n/a | yes |
| db\_password | The password to the database | `string` | n/a | yes |
| db\_private\_ip | The IP address to the database to connect to | `string` | n/a | yes |
| gcs\_backend | The GCS bucket used for arifacts storage | `string` | n/a | yes |
| module\_depends\_on | The dependecies of the cloud-run module | `any` | null | no |
| network\_short\_name | The name of the network where the database instance is connected. | `string` | n/a | yes |
| brand\_name | if the create_band input is 0 (if it exists) enter the name of the brand | `string` | n/a | no |
| support\_email | Person or group to contact in case of problems | `string`| n/a | yes |
| oauth\_client\_id | if the create_band input is 0 (if it exists) enter the name of the Oauth Client Id | `string` | n/a | no |
| oauth\_client\_secret | if the create_band input is 0 (if it exists) enter the OAuth Client Secret for the Oauth Client Id entered above | `string` | n/a | no |
| lb\_name | Name of the load balancer | `string` | `"mlflow-lb"` | no |
| domain | The domain name that is configured to point to the load balancer IP address | `string` | n/a | yes |
| webapp\_users | The list of users who can access the mlflow tracking server from the domain (webpage) | `list(string)` | n/a | yes |
| logger\_email | The email responsible for logging the artifacts in the GCS bucket | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| load\_balancer\_ip | The load balancer's IP address that your domain / subdomain should point to |
| oauth\_redirect\_url | The Oauthentication redirect url that you add to the you OAuth 2.0 Client ID's list of authorized urls |
| created\_brand\_name | The brand name created by Terraform for you (if you didn't enter any brand name in the Inputs) |
