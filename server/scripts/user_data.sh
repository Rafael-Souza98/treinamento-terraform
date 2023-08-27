#!/bin/bash
yum update -y
yum install ${PACKAGE_NAME} -y
systemtl enable ${SERVICE_NAME}--now

if [${PACKAGE_NAME} == "httpd"] || [${PACKAGE_NAME} == "nginx"]; then
    echo "<h1>Criado via terraform</h1>"
fi
