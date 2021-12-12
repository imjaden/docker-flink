#!/usr/bin/env bash

echo ${FLINK_HOME}/bin/sql-client.sh embedded --library ${SQL_CLIENT_HOME}/lib
${FLINK_HOME}/bin/sql-client.sh embedded --library ${SQL_CLIENT_HOME}/lib
