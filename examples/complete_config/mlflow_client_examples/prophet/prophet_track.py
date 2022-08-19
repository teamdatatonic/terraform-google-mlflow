import os
import sys
import json
import mlflow
import pandas as pd
import numpy as np
from pathlib import Path
from prophet import Prophet, serialize
from prophet.diagnostics import cross_validation, performance_metrics

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import mlflow_config


def extract_params(pr_model):
    return {attr: getattr(pr_model, attr) for attr in serialize.SIMPLE_ATTRIBUTES}


if __name__ == "__main__":

    retail_csv = "https://raw.githubusercontent.com/facebook/prophet/master/examples/example_retail_sales.csv"

    artifact_path = "model"
    np.random.seed(213)

    try:
        retail_df = pd.read_csv(retail_csv)
    except Exception as e:
        print("Unable to download the retail sales data. Error: %s", e)

    data_path = str(str(Path(__file__).parent / "retail_sales.csv"))
    retail_df.to_csv(data_path)

    with mlflow.start_run():
        mlflow.log_artifact(data_path)
        model = Prophet().fit(retail_df)

        params = extract_params(model)

        metrics_keys = ["mse", "rmse", "mae", "mape", "mdape", "smape", "coverage"]
        metrics_raw = cross_validation(
            model=model,
            horizon="365 days",
            period="180 days",
            initial="710 days",
            parallel="threads",
            disable_tqdm=True,
        )

        cv_metrics = performance_metrics(metrics_raw)
        metrics = {k: cv_metrics[k].mean() for k in metrics_keys}

        print(f"Logged Metrics: \n {json.dumps(metrics, indent=2)}")
        print(f"Logged Parameters: \n {json.dumps(params, indent=2)}")

        mlflow.prophet.log_model(
            model, artifact_path=artifact_path, registered_model_name="prophet_model"
        )
        mlflow.log_params(params)
        mlflow.log_metrics(metrics)
        model_uri = mlflow.get_artifact_uri(artifact_path)
        print(f"Model logged to: {model_uri} ")

    loaded_model = mlflow.prophet.load_model(model_uri)

    forecast = loaded_model.predict(loaded_model.make_future_dataframe(60))

    print(f"forecast:\n${forecast.head(30)}")
