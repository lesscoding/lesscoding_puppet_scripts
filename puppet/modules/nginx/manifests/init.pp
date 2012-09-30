class nginx {

  package {
    "nginx":
      ensure => present,
  }

  file { "/etc/nginx/nginx.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nginx/nginx.conf",
    require => Package["nginx"],
  }

  service { "nginx":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package["nginx"],
  }
}
