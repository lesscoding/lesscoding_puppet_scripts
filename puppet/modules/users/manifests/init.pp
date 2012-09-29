class users {

  group { "emson":
    ensure => 'present',
  }

  group { "lesscoding":
    ensure => 'present',
  }

  user { "lesscoding":
     gid => 'lesscoding',
     comment => 'The application user',
     managehome => 'false',
     ensure => 'present',
     require => Group['lesscoding'],
  }

  user { "emson":
     gid => 'emson',
     comment => 'emson user',
     managehome => 'true',
     ensure => 'present',
     shell => '/bin/bash',
     require => Group['emson'],
  }

  ssh_authorized_key { "emson":
    ensure => "present",
    type => "ssh-rsa",
    key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDLYkj+YFIorwYEQjKfq4IQnPv5YeNL2J+jP8n111fdMSNbBgnpGbtxaYrqe/TSQpqFfGwd+nSUfl6kz+Ya/qIcZULyN6ycG2PV1VCtfhhHouwj8u3Q2fw8vEaUHd0oo03i0ugFoAVoo3kA5PS9VIItxV93yBXMt7GpmqxzQbi/rMed+yM1YlQurd0UwvJMLSrIllr/YLIBTT7QHRmq9lSEz4+bOdt0SIBRW6n5ZiZoSgPt/EjQrYTjJ8lC/+NekT6vQvO2Ot+s1BAyIzQbRoBmPoFU1tP4y14eLiXLH+XLR3W/T5XfH2mVTPlpcNNzwwP6lo05St61IEz4otTc23rj",
    user => "emson"
  }

}
