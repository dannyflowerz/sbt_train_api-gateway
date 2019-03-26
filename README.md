# api-gateway
API gateway for the microservices 

## GCP

### Upload jar file to bucket
```
gsutil cp target/api-gateway-0.0.1-SNAPSHOT.jar \
    gs://sbt-train-bucket/api-gateway.jar
```

### Create compute instance for service
```
gcloud compute instances create api-gateway-instance \
--image-family debian-9 \
--image-project debian-cloud \
--machine-type g1-small \
--scopes "userinfo-email,cloud-platform" \
--metadata-from-file startup-script=instance-startup.sh \
--metadata BUCKET=sbt-train-bucket \
--zone europe-west2-a \
--tags api-gateway
```

### Crete firewall rule to allow access on 8761
```
gcloud compute firewall-rules create default-allow-http-8080 \
    --allow tcp:8080 \
    --source-ranges 0.0.0.0/0 \
    --description "Allow port 8080 access to all targets"
```

### Stop instance to avoid extra costs
```
gcloud compute instances stop api-gateway-instance
```
