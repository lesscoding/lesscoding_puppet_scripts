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

<https://github.com/jonhadfield/puppet-wordpress

<http://puppetlabs.com/blog/using-puppet-modules-to-install-and-manage-wordpress/>


#### Setup FastCGI First

<http://library.linode.com/web-servers/nginx/php-fastcgi/ubuntu-11.04-natty>


## TODO

Script to:


<http://library.linode.com/securing-your-server>
  - remove ssh for root
