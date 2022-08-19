# Network Module

Creates a VPC network with a firewall that allows internal connections only

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
| Project\_id | The project name you want to enable the services for | `string` | n/a | yes |
| network\_name | The name of the Google Cloud network to attach to. If null a new network will be create | `string` | n/a | no |
| network\_name\_local | The name of the network to create if network_name is null | `string` | `"mlflow-network"` | no |


## Outputs

| Name | Description |
|------|-------------|
| network\_self\_link | The URI of the created network |
| network\_short\_name | The name of the created network
