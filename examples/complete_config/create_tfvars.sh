#!/bin/bash

# splits our enviroment variable webapp_users into an array
IFS=',' read -a arr <<< "$webapp_users"

cat << EOF > ./terraform.tfvars
project_id = "${project_id}"
region     = "${region}"
zone       = "${zone}"
db_name    = "${db_name}"
db_version = "${db_version}"
db_tier    = "${db_tier}"
mlflow_docker_image = "${mlflow_docker_image}"
brand_name          = "${brand_name}"
domain              = "${domain}"
support_email       = "${support_email}"
webapp_users        = [$( printf '"%s",' "${arr[@]}")]
oauth_client_id     = "${oauth_client_id}"
oauth_client_secret = "${oauth_client_secret}"
EOF
