class newton {
  file {
    ["/var/www/",
     "/var/www/lesscoding/",
     "/var/www/lesscoding-wp/"]:
       ensure => directory,
       owner => lesscoding,
       group => lesscoding,
       mode => 775,
  }

  host {
    "newton.lesscoding.com":
    ip => "176.58.101.12",
    host_aliases => "newton",
  }

  package {
    "fail2ban":
      name => "fail2ban",
      ensure  => installed,
  }

  package {
    "vim":
      name => "vim",
      ensure  => installed,
  }

  package {
    "bundler":
      provider => gem,
  }

}
