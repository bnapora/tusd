# Deploy to GCP Cloud Run

## Build Image
docker build -f Dockerfile --tag us-west2-docker.pkg.dev/gcp-pathology-poc1/pathcloud/tusd-go ../.

## Build Image w/ NGinx
docker build -f Dockerfile.nginx --tag us-west2-docker.pkg.dev/gcp-pathology-poc1/pathcloud/tusd-go-nginx .

## Test Image
docker run us-west2-docker.pkg.dev/gcp-pathology-poc1/pathcloud/tusd-go:latest

## Push Image
docker push us-west2-docker.pkg.dev/gcp-pathology-poc1/pathcloud/tusd-go

## Deploy to GCP Cloud Run
**Create Buckets**
`gcloud storage buckets create gs://transform-image-upload --location=us-west2`

```
gcloud config set project gcp-pathology-poc1 && \
gcloud beta run deploy upload-service-tusd --image us-west2-docker.pkg.dev/gcp-pathology-poc1/pathcloud/tusd-go \
--region=us-west2 --allow-unauthenticated --execution-environment gen2 \
--memory 4G \
--add-volume name=tusd-data,type=cloud-storage,bucket=transform-image-upload \
--add-volume-mount volume=tusd-data,mount-path=/srv/tusd-data
```

# Deploy Standard Image to GCP Cloud Run (090425)

## Deploy to GCP Cloud Run
**Create Buckets**
`gcloud storage buckets create gs://transform-image-upload --location=us-west2`

```
gcloud config set project gcp-pathology-poc1 && \
gcloud beta run deploy upload-service-tusd --image tusproject/tusd:latest \
--region=us-west2 --allow-unauthenticated --execution-environment gen2 \
--memory 4G \
--add-volume name=tusd-data,type=cloud-storage,bucket=transform-image-upload \
--add-volume-mount volume=tusd-data,mount-path=/data \
--args "-upload-dir=/data" \
--args "-cors-allow-origin=*" \
--args "-cors-allow-methods=POST,GET,HEAD,PATCH,OPTIONS" \
--args "-cors-allow-headers=Authorization,Content-Type,Upload-Length,Upload-Offset,Tus-Resumable,Upload-Metadata,Upload-Defer-Length,Upload-Concat"


--args "-upload-dir=/data" \
--args "-cors-allow-origin=*" \
--args "-cors-allow-methods=POST,GET,HEAD,PATCH,OPTIONS" \
--args "-cors-allow-headers=Authorization,Content-Type,Upload-Length,Upload-Offset,Tus-Resumable,Upload-Metadata,Upload-Defer-Length,Upload-Concat" 


```