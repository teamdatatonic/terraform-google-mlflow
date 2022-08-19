help:
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

cloud-build: ## builds the docker container on GCP and pushes it the artifact registry.
	@echo "Building mlflow-server image on Gcloud..."
	@gcloud builds submit --tag ${mlflow_docker_image} ./mlflow-server-container
	@echo "Image built."
	@echo

create-tfvars: ## Gets all the variables defined in .envrc and then creates the terraform.tfvars to pass the necessary variables to terraform.
	@echo "Creating terraform variables..."
	@chmod +x create_tfvars.sh && ./create_tfvars.sh
	@echo "Done"
	@echo

apply-terraform: ## deploys all the resources required for mlflow to run on GCP.
	@echo "Applying terraform..."
	@terraform init && terraform apply -auto-approve
	@echo "Done"
	@echo

destroy-terraform: ## destorys all the the resources deployed in apply-terraform
	@echo "Destroying terraform..."
	@terraform destroy -auto-approve
	@echo "Done"
	@echo

deploy-mlflow: ## Builds the mlflow infrastructure on GCP.
	cloud-build create-tfvars apply-terraform

destroy: ## Destroys the mlflow infrastructure built on GCP.
	destroy-terraform
