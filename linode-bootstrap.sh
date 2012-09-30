#!/bin/bash

# Bootstrap script to install the basic packages necessary for running puppet
# This script assumes that you have already:
#   - set the hostname

# update your system
echo "Updating..."
sudo apt-get update -y
echo "Upgrading"
sudo apt-get upgrade -y --show-upgrade
# install basic packages
echo "Installing packages..."
sudo apt-get install -y curl git-core libcurl4-gnutls-dev libreadline-dev libssl-dev libyaml-dev \
                        zlib1g-dev build-essential python-software-properties ruby1.9.3 puppet
# get the puppet scripts
# TODO get these from github
echo "Get puppet scripts..."
rm -rf /tmp/provision
cd /tmp && git clone git://github.com/lesscoding/lesscoding_puppet_scripts.git provision
sudo cp -r /tmp/provision/puppet /etc

# run the puppet scripts
echo "Execute puppet scripts..."
sudo puppet apply /etc/puppet/manifests/site.pp
echo "Completed!"
