#!/bin/bash

# set the hostname
HOSTNAME="newton"
# get the ip address
IPADDR=`ip -f inet -r addr | egrep -o "(([0-9]{3}+).*)/24" | sed 's/\/24//'`
# set the Fully Qualified Domain Name
FQDN="newton.lesscoding.com"

# set the hostname
rm /etc/hostname
echo $HOSTNAME > /etc/hostname
# set the host file
echo $IPADDR $HOSTNAME $FQDN >> /etc/hosts

# get and execute the puppet script
wget https://raw.github.com/lesscoding/lesscoding_puppet_scripts/master/linode-bootstrap.sh --output-document=/opt/linode-bootstrap.sh
chmod +x /opt/linode-bootstrap.sh

./opt/linode-bootstrap.sh
