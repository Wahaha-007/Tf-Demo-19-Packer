#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2
#sudo chmod -R 755 /var/www/html # No need
sudo chown -R ubuntu:ubuntu /var/www/html 
#Need chown line to be able to upload file
