#!/bin/bash
yum update -y
yum install ${PACKAGE_NAME} -y
systemtl enable ${SERVICE_NAME}--now
