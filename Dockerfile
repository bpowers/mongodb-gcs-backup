FROM mongo:4-bionic

RUN apt update && apt install -y curl \
 && echo "deb http://packages.cloud.google.com/apt cloud-sdk-xenial main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -\
 && apt-get update \
 && apt-get install -y google-cloud-sdk


ADD ./backup.sh /mongodb-gcs-backup/backup.sh
WORKDIR /mongodb-gcs-backup

RUN chmod +x /mongodb-gcs-backup/backup.sh

ENTRYPOINT ["/mongodb-gcs-backup/backup.sh"]
