# Mlflow Deployment GCP Example

## Introduction

This an example for deploying an [mlflow](https://mlflow.org/) server on cloud run. Using Datatonic's Mlflow module

## Getting Started.
### Prerequisites
* python 3.10.4
* [Google Cloud CLI](https://cloud.google.com/sdk/docs/quickstart)
* [pyenv](https://github.com/pyenv/pyenv/wiki#suggested-build-environment)
* [Poetry](https://python-poetry.org/)
* [direnv](https://direnv.net/)
* [Pre-commit](https://pre-commit.com/)
* [Terraform](https://www.terraform.io/)
* You must have a domain / subdomain registered, for which you can modify its DNS settings.

### Setup
* Run `pyenv install 3.10.4` to install python 3.10.4, then run `pyenv shell 3.10.4` to set python 3.10.4 as the python version for the current shell
* Run `poetry install` to install all the required dependencies.
* Run `Pre-commit install` to install all the pre-commit hooks that run on every commit to automatically point out issues in code
* Run `gcloud auth application-default login` to login to you account using Google Cloud CLI.
* Make sure direnv is hooked to your shell by running
```bash
# bash users - add the following line to your ~/.bashrc
eval "$(direnv hook bash)"

# zsh users - add the following line to your ~/.zshrc
eval "$(direnv hook zsh)"
```
* [Create OAuth2.0 credentials](https://support.google.com/cloud/answer/6158849?hl=en#zippy=)
* Copy `.envrc.sample` to `.envrc` and update the the environment variables in `.envrc` to your values.

> **Things to note**
>
> The domain variable can either be a domain or a subdomain.
>
> To add web app users, you have to specify if the account being added is a user or a service account i.e "user:user_email_address,serviceAccount:service_account_email_address"
>
> Only include the brand_name, oauth_client_id, oauth_client_secret variables (in the .envrc file) if you have [OAuth 2,0](https://developers.google.com/identity/protocols/oauth2) already configured.

* Load the env variables in `.envrc` by running `direnv allow .`

### Deploying The Platform

To deploy the platform run `make deploy-mlflow` and wait for the create brand prompt.

The deployment should take around 20 minutes.

After it's complete you will get the name of the entered brand, an IP address `lb_ip` and a url `oauth2_redirect_uri` as the output.

#### Other make commands

* `cloud-build`: builds the docker container on GCP and pushes it the container registry.
* `create-tfvars`: Gets all the variables defined in `.envrc` and then creates the terraform.tfvars to pass the necessary variables to terraform.
* `apply-terraform`: deploys all the resources required for mlflow to run on GCP.
* `destroy-terraform`: destorys all the the resources deployed in `apply-terraform`.

### Post-deployment steps

After deploying the infrastructure we have some configuration to do to ensure IAP works. These steps are;

* Configure DNS records of the used domain name with the given IP address i.e add a type A record named www or your subdomain name, pointing to your IP address gotten from the *deploying the Infrastructure* step, which was the output of your terraform command

* Go to [Google Cloud credentials page](https://console.cloud.google.com/apis/credentials) select the correct OAuth 2.0 Client ID and add the `oauth2_redirect_uri` output (gotten from the *deploying the Infrastructure* step) to the Authorized Redirect URIs list.

Wait for a few minutes, enter your domain / sub domain on your browser and login to mlflow ui

## Pushing Parameters, Metrics, and Artifacts

In the examples folder we have example scripts that show how you can log the artifacts, parameters, and metrics for specific ML frameworks (Keras, Sklearn and prophet). You can run them by:

```bash
cd mlflow_client_examples/sklearn
python -m venv venv
source venv/bin/activate
poetry install
python sklearn_track.py
```

To have tracking in your own model / script all you have to do is copy the `mlflow_config.py` file in the examples folder to the same directory you are running your script and import it in your script.

Configure your script to match the mlflow format in the one of the examples scripts (sklearn_track, keras_track and prophet_track) that best matches your use case and you're good to go.

For sklearn models and models from other libraries prophet, xgboost e.t.c requires you to use mlflow.start_run() while for tensorflow models all you have to do is import the autolog function from mlflow.tensorflow

## Destory the platform

Run `make destroy` to disable both the services enabled and the resources created for the project.

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
| created\_brand\_name | The brand name created by Terraform for you (if you didn't enter any brand name in the Inputs) |
