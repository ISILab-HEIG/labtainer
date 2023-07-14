#!/bin/bash
#
#  This script will be run after parameterization has completed, e.g., 
#  use this to compile source code that has been parameterized.
#  The container user password will be passed as the first argument,
#  (the user ID is the second parameter)
#  If this script is to use sudo and the sudoers for the lab
#  does not permit nopassword, then use:
#  echo $1 | sudo -S the-command
#
#  If you issue commands herein to start services, and those services
#  have unit files prescribing their being started after the
#  waitparam.service, then first create the flag directory that
#  waitparam sleeps on:
#
#   PERMLOCKDIR=/var/labtainer/did_param
#   echo $1 | sudo -S mkdir -p "$PERMLOCKDIR"

echo $1 | sudo usermod -a -G redis www-data
echo $1 | sudo usermod -a -G www-data redis
echo $1 | sudo systemctl start apache2
echo $1 | sudo chmod -R 777 /var/www/html 

service_file="/lib/systemd/system/redis-server.service"
tmp_file="/tmp/redis-server.service"

# Create a temporary file with the updated content
echo $1 | sudo sed '/ReadWritePaths=-\/var\/run\/redis/a ReadWritePaths=-\/var\/www\/html' "$service_file" > "$tmp_file"

# Move the temporary file to replace the original service file
echo $1 | sudo mv "$tmp_file" "$service_file"

# Create a temporary file with the updated content
echo $1 | sudo sed 's/^UMask=007/UMask=002/' "$service_file" > "$tmp_file"

# Move the temporary file to replace the original service file
echo $1 | sudo mv "$tmp_file" "$service_file"

echo $1 | sudo service redis-server stop
echo $1 | sudo systemctl daemon-reload
echo $1 | sudo service redis-server start

#ADAPT ME with your network settings
echo $1 | sudo route del default gw 172.22.0.1
echo $1 | sudo route add default gw 192.168.1.1


