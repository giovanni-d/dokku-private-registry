# Dokku Private Registry

Private registry server deployed as a dokku app with HTTP Basic auth using
`AUTH_USER` and `AUTH_PASSWORD` env variables.

## Setup

```bash
dokku apps:create registry
dokku config:set registry REGISTRY_HTTP_SECRET=$(openssl rand -hex 64)
dokku config:set registry AUTH_USER=user AUTH_PASSWORD=$(openssl rand -hex 16)
dokku storage:mount registry /var/lib/dokku/data/storage/registry:/var/lib/registry
dokku ps:set registry restart-policy unless-stopped
dokku domains:add registry my-registry.example.com
dokku letsencrypt:active registry
```

## Deploy

```bash
git remote add dokku dokku@dokku.example.com:my-registry
git push dokku master
```

## Test

```bash
docker login -u user -p password my-registry.example.com

docker pull busybox:latest
docker tag busybox:latest my-registry.example.com/user/busybox:latest
docker push my-registry.example.com/user/busybox:latest
docker rmi busybox:latest my-registry.example.com/user/busybox:latest
docker pull my-registry.example.com/user/busybox:latest
```

## Garbage Collect

```bash
dokku run my-registry /bin/registry garbage-collect /app/config.yml
```
