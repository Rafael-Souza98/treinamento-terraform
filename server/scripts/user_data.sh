#!/bin/bash
yum update -y
yum install -y httpd
systemtl enable httpd --now
echo "${WELCOME_MSG}" > /var/www/html/index.html