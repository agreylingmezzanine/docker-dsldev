#!/bin/sh
docker rm -f $(docker ps -a -q --filter="ancestor=ajmezza9/dsldev")
docker rmi ajmezza9/dsldev
# docker build --no-cache --rm -f "Dockerfile" -t ajmezza9/dsldev:latest "."
# docker build --rm -f "Dockerfile" -t ajmezza9/dsldev:latest "."
docker buildx create --use
docker buildx build --platform=linux/amd64,linux/arm64 -f "Dockerfile" --push -t ajmezza9/dsldev:latest "."
# docker push ajmezza9/smsadsldev:latest
docker pull ajmezza9/dsldev:latest
