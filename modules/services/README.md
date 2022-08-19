# Services Module

Enables services for a particular project.

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
| services | List of all the service that need to enabled | `list` | n/a | yes |

## Outputs

No Output
