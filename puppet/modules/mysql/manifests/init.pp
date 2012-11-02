class mysql::server {

  $root_db_password = "mypassword"
  $db_name          = "wp_lesscoding_com"
  $db_user          = "lesscodingdb"
  $db_password      = "apassword"
  
	package { "php5-mysql":
		ensure => installed,
	}

	package { "mysql-server":
		ensure => installed,
		require => Package["php5-mysql"],
	}

  file { "/etc/mysql/my.cnf":
    ensure => file,
    source  => "puppet:///modules/mysql/my.cnf",
    require => Package["mysql-server"],
  }

	service { mysql:
		ensure => running,
		hasstatus => true,
		require => File["/etc/mysql/my.cnf"],
	}

  # file to create the wordpress database
  # and create the wordpress db user
  file { "/tmp/create_database.sql":
    ensure => file,
    require => Service["mysql"],
    content => template('mysql/create_database.sql.erb'),
  }

  # sets the root db password
  exec {
    "set_db_root_password":
      command => "sudo mysqladmin -u root -h localhost password '${root_db_password}'",
      unless => "mysql -uroot -p${root_db_password} -hlocalhost",
      require => File['/tmp/create_database.sql'];

    # create the wordpress database
    "create_db":
      command => "sudo mysql -u root -p${root_db_password} < /tmp/create_database.sql",
      unless => "mysql -u${db_user} -p${db_password} -D${db_name} -hlocalhost",
      require => Exec['set_db_root_password'];

    # clean up the create db file after creation
    "remove_sql_file":
      command => "sudo rm /tmp/create_database.sql",
      require => Exec['create_db'];
  }

}
