import os
import six
import google
import requests
from pathlib import Path
from google.oauth2 import id_token
from google.auth.transport.requests import Request
from subprocess import check_output
from mlflow import set_tracking_uri, set_experiment


def _get_client_id(tracking_uri: str):
    """
    Get the client id for the mlflow logging service account
    """
    redirect_response = requests.get(tracking_uri, allow_redirects=False)
    if redirect_response.status_code != 302:
        print(
            f"The URI {tracking_uri} does not seem to be a valid IAP configured endpoint"
        )
        return None

    redirect_location = requests.get(tracking_uri, allow_redirects=False).headers.get(
        "location"
    )
    if not redirect_location:
        print(f"{tracking_uri} does not redirect to the IAP page")
        return None

    parsed = six.moves.urllib.parse.urlparse(redirect_location)
    query_string = six.moves.urllib.parse.parse_qs(parsed.query)

    return query_string["client_id"][0]


def _get_token(tracking_uri: str):
    """
    Get the token for the mlflow logging service account created in the logger terraform module
    """
    client_id = _get_client_id(tracking_uri)
    open_id_connect_token = id_token.fetch_id_token(Request(), client_id)

    return open_id_connect_token


def fetch_sa_key():
    check_output(
        [
            "gcloud iam service-accounts keys create ../mlflow-logger-key.json "
            f"--iam-account=mlflow-logger@{PROJECT_ID}.iam.gserviceaccount.com"
        ],
        shell=True,
    )
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = str(
        Path(__file__).parent / "mlflow-logger-key.json"
    )


def load_token(tracking_uri: str):
    """
    load the token for the mlflow logging service account
    """
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = ""
    if "mlflow-logger-key.json" in os.listdir(Path(__file__).parent):
        os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = str(
            Path(__file__).parent / "mlflow-logger-key.json"
        )

    try:
        token = _get_token(tracking_uri)
    except google.auth.exceptions.DefaultCredentialsError:
        print("you don't seem to have an mlflow-logger service account key locally. \n")
        prompt = input("Get one? (Y/n): \n") or "y"
        if prompt.lower() == "y":
            print("fetching the mlflow-logger service account key... \n")
            fetch_sa_key()
        token = _get_token(tracking_uri)

    return token


if os.environ["project_id"] == "":
    PROJECT_ID = input("Enter the project name: ")

if os.environ["domain"] == "":
    URI = input("Enter the tracking URI: ")
else:
    URI = "https://" + os.environ["domain"]

if os.environ["mlflow_experiment_name"] == "":
    EXP_NAME = input("Enter the mlflow experiment name: ")

PROJECT_ID = os.environ["project_id"]
EXP_NAME = os.environ["mlflow_experiment_name"]

os.environ["MLFLOW_TRACKING_TOKEN"] = load_token(URI)

set_tracking_uri(URI)
print(f"set tracking URI to {URI}")
set_experiment(EXP_NAME)
print(f"set experiment name to {EXP_NAME}")
