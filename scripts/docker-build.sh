#!/usr/bin/env bash

export FLINK_VERSION=${1:-'usage'}
export SCALA_VERSION=${2:-'usage'}
export IMAGE_VERSION=${SCALA_VERSION}-${FLINK_VERSION}
export DOCKER_TAG=imjaden/flink

case "${FLINK_VERSION}" in
usage)
    echo "Usage:"
    echo "# ./scripts/docker-build.sh <flink-version> <scala-version>"
    echo "Example:"
    echo "$ ./scripts/docker-build.sh 1.14.0 2.12"
    ;;
*)
    echo "Param Kafka: ${FLINK_VERSION}, Scala: ${SCALA_VERSION}"

    echo "Removing local image/container..."
    docker stop flink:${IMAGE_VERSION} 2 &>/dev/null
    docker rm flink:${IMAGE_VERSION} 2 &>/dev/null
    docker image rm flink:${IMAGE_VERSION} 2 &>/dev/null
    docker image rm imjaden/flink:${IMAGE_VERSION} 2 &>/dev/null

    echo "Building docker image..."
    docker build --tag flink:${IMAGE_VERSION} .

    echo "Taging docker image..."
    docker tag flink:${IMAGE_VERSION} ${DOCKER_TAG}:${IMAGE_VERSION}

    echo "Logining docker hub..."
    docker login

    echo "Pushing docker image..."
    docker push ${DOCKER_TAG}:${IMAGE_VERSION}

    echo "Done!"
    ;;
esac
