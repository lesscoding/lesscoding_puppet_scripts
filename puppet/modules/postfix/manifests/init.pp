class postfix {

  package {
    "postfix":
      name => "postfix",
      ensure  => installed,
  }

  # TODO this should be a template with password vars
  file {
  '/etc/postfix/sasl/passwd':
    source => "puppet:///modules/postfix/passwd",
    require => Package['postfix'],
  }

  exec {
    'postfix_mapping':
    command => "sudo postmap /etc/postfix/sasl/passwd",
    subscribe => File['/etc/postfix/sasl/passwd'],
  }

  file {
    '/etc/postfix/main.cf':
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
