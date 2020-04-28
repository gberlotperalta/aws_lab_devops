#!/bin/bash

createuser sonarqube;
echo "ALTER USER sonarqube WITH ENCRYPTED password '$1'; CREATE DATABASE sonarqube OWNER sonarqube; \q" | psql;