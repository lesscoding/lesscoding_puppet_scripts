class timezone::config {

  exec { 'timezone_set':
    command     => 'dpkg-reconfigure -f noninteractive tzdata',
    refreshonly => true,
    require     => File['/etc/timezone'],
  }

  file { '/etc/timezone':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('timezone/timezone.erb'),
    notify  => Exec['timezone_set'],
  }

}
