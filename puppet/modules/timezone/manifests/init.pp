class timezone {

  file {
    "/etc/localtime":
      ensure => "/usr/share/zoneinfo/UTC"
  }

  file {
    "/etc/timezone":
      content => "Etc/UTC\n",
  }

  file {
    "/etc/default/locale":
      content => "LANG=\"en_US.UTF-8\n"
  }

}
