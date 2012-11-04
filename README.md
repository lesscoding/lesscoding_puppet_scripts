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

<http://blog.bigdinosaur.org/postfix-gmail-and-you/>

<http://www.marksanborn.net/linux/send-mail-postfix-through-gmails-smtp-on-a-ubuntu-lts-server/>

<http://codex.wordpress.org/Hardening_WordPress>


#### Setup FastCGI First

<http://library.linode.com/web-servers/nginx/php-fastcgi/ubuntu-11.04-natty>


## TODO

Script to:

* fastCGI
* PHP5
* Wordpress
* MySQL
* Nagios
* Varnish
* log rotation



<http://library.linode.com/securing-your-server>
  - remove ssh for root
