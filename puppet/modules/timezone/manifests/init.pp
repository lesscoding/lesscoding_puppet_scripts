# == Class: timezone
#
# Sets server timezone.
#
# === Parameters
#
# [*timezone*]
#  Timezone to use. Default: America/Los_Angeles
#
# === Examples
#
# class { 'timezone':
#   timezone => 'America/New_York',
# }
#
# === Authors
#
# Sergey Stankevich
#
class timezone (
  $timezone = 'Etc/UTC'
) {

  # Module compatibility check
  $compatible = [ 'Debian', 'Ubuntu' ]
  if ! ($::operatingsystem in $compatible) {
    fail("Module is not compatible with ${::operatingsystem}")
  }

  include timezone::config

}
