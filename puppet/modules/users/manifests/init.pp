class users {

  group { "emson":
    ensure => 'present',
  }

  group { "www-data":
    ensure => 'present',
  }

  user { "www-data":
     gid => 'www-data',
     comment => 'The www-data web server user',
     managehome => 'false',
     ensure => 'present',
     require => Group['www-data'],
  }

  user { "emson":
     gid => 'emson',
     comment => 'emson user',
     managehome => 'true',
     ensure => 'present',
     shell => '/bin/bash',
     require => Group['emson'],
  }

  ssh_authorized_key { "ben@lesscoding.com":
    ensure => "present",
    type => "ssh-rsa",
    key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCtJc25smfKdZHLb90MeWcXoTbTmJ+4yiGtiEE8aaxkP5tbYS4fhEAs3Hk3PhR0lQ9f/vZA/yqL92zPOzKF8igL925xU2727Yju65bXM327+JO24q0+L3SNH5lFNqaEx0EICJH4FMsIcyARz89n4+fEueuqT9fFo00TMiNLuDs2bSOtIqMSgn1LcMC62hc2E9I38fo9M3l6uBwp+w5XvuapuoCzeRrifblOgNKVVWHiXxHXe0QzgRwZsgzxVcFCP92j3yIcq5LSDJEqxmwOrLEQCPfY02e1i/u1hT4JOjL36Nbx12aEkJyvdMOtsVttRrddMQ/fyEDDlb5QIhArObLX",
    user => "emson"
  }

  file { '/home/emson/.bash_profile':
    owner => 'emson',
    group => 'emson',
    mode => 644,
    source => "puppet:///modules/users/bash_profile",
    require => User['emson'],
  }

  # TODO doesn't work: install vimben
  # exec {
  #   "vimben":
  #     command => 'curl -Lo- https://raw.github.com/emson/vimben/master/bootstrap.sh | bash | 0',
  #     require => User['emson'],
  # }


}
