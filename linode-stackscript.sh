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
wget http://example.com/ --output-file=/opt/deployment-script.pl
chmod +x /opt/deployment-script.pl

./opt/deployment-script.pl
