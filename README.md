# DockerFlink

The image is available directly from [Docker Hub](https://hub.docker.com/r/imjaden/flink/), 
Dockerfile for [Apache Flink](http://flink.apache.org/)

## Usage

```
$ docker pull imjaden/flink:2.12-1.14.0
$ docker run -dit --name flink imjaden/flink:2.12-1.14.0
$ docker exec -it flink /bin/bash -c './sql-client.sh'
```

## FlinkSQL Demo

[Maven FlinkSQL Demo](https://github.com/imjaden/maven-flinksql-demo)
