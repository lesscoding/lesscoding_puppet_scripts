#!/bin/bash

host="${1:-root@176.58.101.12}"
echo "....bootstrapping host: $host"

# removes all keys for host from known_hosts file
ssh-keygen -R "${host#*@}" 2> /dev/null

# recursively copy the puppet directory to the host
scp -i ~/.ssh/my_aws.pem -r puppet $host:/home/ubuntu/
ssh -i ~/.ssh/my_aws.pem "$host" '
sudo apt-get update -y
sudo apt-get install -y curl git-core libcurl4-gnutls-dev libreadline-dev libssl-dev libyaml-dev zlib1g-dev ruby1.9.3
sudo rm -rf /etc/puppet
sudo cp -r ~/puppet /etc/ && rm -rf ~/puppet
sudo puppet apply /etc/puppet/manifests/site.pp
'

