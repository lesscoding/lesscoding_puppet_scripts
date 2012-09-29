class firewall {

  file {
    "/etc/iptables.firewall.rules":
      owner => root,
      group => root,
      mode => 700,
      ensure => present,
      source => "puppet:///modules/firewall/iptables.firewall.rules",
  }

  exec {
    "set_firewal_rules":
      command => "iptables-restore < /etc/iptables.firewall.rules",
      onlyif => "ls /etc/iptables.firewall.rules",
  }

  file {
    "/etc/network/if-pre-up.d/firewall":
      owner => root,
      group => root,
      mode => 751,
      ensure => present,
      source => "puppet:///modules/firewall/firewall",
  }

}
