# LessCoding Server Provisioning Scripts

Scripts to set up the lesscoding server.


## Vagrant

    $ gem install vagrant

Start your Vagrant server:

    $ vagrant up
    $ vagrant ssh
    vm$ cd /tmp/provision
    vm$ . ./linode-bootstrap.sh

## Wordpress

<http://puppetlabs.com/blog/using-puppet-modules-to-install-and-manage-wordpress/>


## TODO

Script to:

- create Ubuntu 12.04 LTS 64bit

create root ssh keys for root.

Linode StackScript:
  - create hostname
  - update /etc/hosts
  - run Linode bootstrap script

get bootstrap script
  - apt-get update
  - apt-get upgrade --show-upgrade
  - install Git
  - install ruby
  - install puppet
  - clone linode_puppet.git
  - run puppet

Puppet script
  - lesscoding 
    - install bundler
    - add lesscoding user
    - set timezone
  - ntp

<http://library.linode.com/securing-your-server>
  - create emson user
  - Add ssh key
  - remove ssh for root
  - create firewall
  - install Fail2Ban
  
Install Web Server
