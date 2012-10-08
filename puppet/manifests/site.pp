Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

include timezone
include ntp
include firewall
include users
include newton

include lesscoding
include fastcgi
# run nginx after starting fastcgi 
# and any other services
include nginx
