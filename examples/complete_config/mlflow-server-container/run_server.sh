#!/bin/bash

# BACKEND_URI=mysql+pymysql://${DB_USERNAME}:${DB_PASSWORD}@${DB_PRIVATE_IP}:3306/${DB_NAME}
BACKEND_URI=postgresql+psycopg2://${DB_USERNAME}:${DB_PASSWORD}@${DB_PRIVATE_IP}:5432/${DB_NAME}
# mlflow db upgrade ${BACKEND_URI} || true

echo ${GCP_BUCKET}

mlflow server \
    --backend-store-uri=${BACKEND_URI} \
    --default-artifact-root=${GCP_BUCKET} \
    --host 0.0.0.0 \
    --port ${PORT}
