#!/bin/sh

set -x
# output log of userdata to /var/log/user-data.log
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y