class postfix {

  package {
    "postfix":
      name => "postfix",
      ensure  => installed,
  }

  file { "/etc/postfix/sasl/passwd":
    content => template("postfix/passwd.erb"),
    require => Package['postfix'],
  }

  file {
  "/etc/postfix/generic":
    content => template("postfix/generic.erb"),
    require => Package['postfix'],
  }

  exec {
    "postfix_mapping_passwd":
    command => "sudo postmap /etc/postfix/sasl/passwd",
    subscribe => File['/etc/postfix/sasl/passwd'],
  }

  exec {
    "postfix_mapping_generic":
    command => "sudo postmap /etc/postfix/generic",
    subscribe => File['/etc/postfix/generic'],
  }

  file {
    "/etc/postfix/main.cf":
      source => "puppet:///modules/postfix/main.cf",
      require => Package['postfix'],
  }

  service { postfix:
    enable => true,
    ensure => running,
    hasstatus => true,
    subscribe => File["/etc/postfix/main.cf"],
  }

}
