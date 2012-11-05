# LessCoding Server Provisioning Scripts

Scripts to set up the lesscoding server.


## Vagrant

    $ gem install vagrant

Start your Vagrant server:

    $ vagrant up
    $ vagrant ssh
    vm$ cd /tmp/provision
    vm$ . ./linode-bootstrap.sh

## Postfix

<http://blog.bigdinosaur.org/postfix-gmail-and-you/>

<http://www.marksanborn.net/linux/send-mail-postfix-through-gmails-smtp-on-a-ubuntu-lts-server/>

<http://ubuntulinux.co.in/blog/ubuntu/set-up-postfix-for-relaying-emails-via-gmail-smtp-server/>

<http://serverfault.com/questions/54069/how-to-setup-ubuntu-mail-server-with-google-apps>

<http://ubuntu-tutorials.com/2008/11/11/relaying-postfix-smtp-via-smtpgmailcom/>

[Configure MX records on
GMail](http://support.google.com/a/bin/answer.py?hl=en&answer=140034)

[GMail MX record
values](http://support.google.com/a/bin/answer.py?hl=en&answer=174125)


## Wordpress

<https://github.com/jonhadfield/puppet-wordpress>

<http://puppetlabs.com/blog/using-puppet-modules-to-install-and-manage-wordpress/>

<http://codex.wordpress.org/Hardening_WordPress>

<http://evansolomon.me/notes/faster-wordpress-multisite-nginx-batcache/>


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
