Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

include timezone
include ntp
include firewall
include users
include newton

include nginx
include lesscoding

