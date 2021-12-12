FROM maven:3.8.4-jdk-8-slim AS builder
FROM flink:1.14.0-scala_2.12

ENV SQL_CLIENT_HOME /opt/sql-client

WORKDIR /opt/sql-client

COPY scripts/sql-client.sh scripts/entrypoint.sh /opt/sql-client/
COPY configs/*.yaml /opt/flink/conf/

RUN mkdir -p /opt/sql-client/lib; \
    wget -P /opt/sql-client/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka_2.12/1.14.0/flink-sql-connector-kafka_2.12-1.14.0.jar

ENTRYPOINT ["./entrypoint.sh"]
