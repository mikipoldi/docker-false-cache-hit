## Pre-requisites
having docker registry running on host.docker.internal:5000 (images uses it as prefix for their names, but you can change it to your own registry)

## Create multi-platform builder
```shell
docker buildx create --name multi-platform --use
```
git init
## Set all files in repo to epoch
```shell
find . -exec touch -t 197001010000 {} \;
```

## Clean cache just for sure
```shell
docker buildx prune --builder multi-platform --all --force
```

## Build basejava image
```shell
docker buildx build --progress plain --pull -f Dockerfile -t host.docker.internal:5000/basejava . --builder=multi-platform --platform=linux/amd64,linux/arm64 --provenance=false --push
```

## Build appx and appy images - preserve order of commands, important!
```shell
docker buildx build --progress plain --pull -f appx/docker/Dockerfile -t host.docker.internal:5000/appx appx/docker/ --builder=multi-platform --platform=linux/amd64,linux/arm64 --provenance=false --push
docker buildx build --progress plain --pull -f appy/docker/Dockerfile -t host.docker.internal:5000/appy appy/docker/ --builder=multi-platform --platform=linux/amd64,linux/arm64 --provenance=false --push
```

## now run the appy (second app)
```shell
docker run host.docker.internal:5000/appy:latest@sha256:<PUT_YOUR_HASH_FROM_APPY_HERE>
```
This shouldnt, but it does fail to class not found exception. it simply uses MANIFEST.MF from another app!
