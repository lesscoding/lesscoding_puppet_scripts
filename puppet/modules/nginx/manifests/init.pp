class nginx {

  package {
    "nginx":
      ensure => present,
  }

  # remove the default nginx page
  file { "/etc/nginx/sites-enabled/default":
    ensure => absent,
    require => Package["nginx"],
  }

  # add our global nginx.conf file
  file { "/etc/nginx/nginx.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nginx/nginx.conf",
    require => Package["nginx"],
  }

  # ensure that nginx is on and running
  # AFTER php-fastcgi
  service { "nginx":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Service["php-fastcgi"],
    subscribe => Service['php-fastcgi'],
  }
}
