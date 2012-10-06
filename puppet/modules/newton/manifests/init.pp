class newton {

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
    "rake":
      provider => gem,
  }

  package {
    "bundler":
      provider => gem,
  }

}
