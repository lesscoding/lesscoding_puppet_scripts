Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

$app_dir          = "/var/www/lesscoding_com/"
$root_db_password = "mypassword"
$db_name          = "wp_lesscoding_com"
$db_user          = "lesscodingdb"
$db_password      = "apassword"

include timezone
include ntp
include firewall
include users
include newton

# include postfix
include lesscoding
include fastcgi
# run nginx after starting fastcgi 
# and any other services
include nginx

include mysql::server
include wordpress

