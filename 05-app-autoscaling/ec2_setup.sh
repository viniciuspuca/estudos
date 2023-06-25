#!/usr/bin/env bash
set -eo pipefail

sudo apt-get update
sudo apt-get install -y apache2
echo 'Hello from Terraform' > /var/www/html/index.html
service httpd start

sudo apt-get install stress-ng -y

#----------------------------------------------------------------
# COMANDO PARA RODAR O STRESS NA MAQUINA
# sudo stress-ng --cpu 32 --timeout 180 --metrics-brief