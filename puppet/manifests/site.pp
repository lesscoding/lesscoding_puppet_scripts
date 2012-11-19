Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

$extlookup_datadir = "/etc/puppet/manifests/extdata"
$extlookup_precedence = ["%{fqdn}", "domain_%{domain}", "settings"]

$app_dir          = extlookup("app_dir"          , "/var/app/my_app_dir/")
$root_db_password = extlookup("root_db_password" , "root_db_password")
$db_name          = extlookup("db_name"          , "wordpress_db_name")
$db_user          = extlookup("db_user"          , "db_user")
$db_password      = extlookup("db_password"      , "db_password")
$email_account    = extlookup("email_account"    , "my_name@somewhere.com")
$email_password   = extlookup("email_password"   , "email_password")

include timezone
include ntp
include firewall
include users
include newton

include postfix
include lesscoding
include fastcgi
# run nginx after starting fastcgi 
# and any other services
include nginx

include mysql::server
include wordpress

