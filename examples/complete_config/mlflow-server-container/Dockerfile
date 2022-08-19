FROM google/cloud-sdk:latest

RUN mkdir -p /mlflow/ \
    && apt-get update --allow-releaseinfo-change \
    && apt-get -y install --no-install-recommends apt-transport-https \
    ca-certificates gnupg default-libmysqlclient-dev libpq-dev build-essential curl

WORKDIR /mlflow/

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY run_server.sh .
RUN chmod +x run_server.sh

CMD /mlflow/run_server.sh
