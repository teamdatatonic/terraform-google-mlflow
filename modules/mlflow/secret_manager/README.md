## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_secret_manager_secret.secret](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_secret_manager_secret) | resource |
| [google-beta_google_secret_manager_secret_version.secret-version](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_secret_manager_secret_version) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_module_depends_on"></a> [module\_depends\_on](#input\_module\_depends\_on) | modules that this module depends on | `any` | `null` | no |
| <a name="input_secret_id"></a> [secret\_id](#input\_secret\_id) | Name of the secret you want to create | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_value"></a> [secret\_value](#output\_secret\_value) | value of the password created by the secret manager |
