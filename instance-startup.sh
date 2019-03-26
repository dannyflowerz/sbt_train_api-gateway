#!/bin/sh

# Set the metadata server to the get project id
PROJECTID=$(curl -s "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")
BUCKET=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/attributes/BUCKET" -H "Metadata-Flavor: Google")

echo "Project ID: ${PROJECTID} Bucket: ${BUCKET}"

# Get the files we need
gsutil cp gs://${BUCKET}/api-gateway.jar .

# Install dependencies
apt-get update
apt-get -y --force-yes install openjdk-8-jdk

# Make Java 8 default
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

# Start server
java -DEUREKA_URI=http://35.246.52.225:8761/eureka -jar api-gateway.jar >> application.log
# TODO replace IP with current address of service-registry