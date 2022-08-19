## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database.mlflow_db](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.mlflow_db_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.mlflow_db_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_id.db_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | The type of availability for the database instance. | `string` | `"ZONAL"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database instance to create. | `string` | `"mlflow_db"` | no |
| <a name="input_db_tier"></a> [db\_tier](#input\_db\_tier) | The tier of the database to create. | `string` | `"df-f1-micro"` | no |
| <a name="input_db_version"></a> [db\_version](#input\_db\_version) | The version of the database to create. | `string` | `"POSTGRES_13"` | no |
| <a name="input_instance_prefix"></a> [instance\_prefix](#input\_instance\_prefix) | name of database instance you want to create | `string` | `"mlflow"` | no |
| <a name="input_module_depends_on"></a> [module\_depends\_on](#input\_module\_depends\_on) | module that this module depends on | `any` | `null` | no |
| <a name="input_network_self_link"></a> [network\_self\_link](#input\_network\_self\_link) | The self link of the network to use for the database instance.(The private network in ../network) | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | The password for the database created. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Google Cloud region in which to provision the resources. | `string` | `"europe-west2"` | no |
| <a name="input_username"></a> [username](#input\_username) | The username for the database created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Database name |
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | Connection string used to connect to the db instance |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP of the db instance |
