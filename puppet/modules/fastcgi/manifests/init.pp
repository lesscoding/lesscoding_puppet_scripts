class fastcgi {

  # set fastcgi user as www-data
  file {
    ["${app_dir}",
     "${app_dir}logs/",
     "${app_dir}blog/" ]:
       ensure => directory,
       owner => www-data,
       group => www-data,
       mode => 775,
       before  =>  File['wordpress_setup_files_dir'];
  }

  # add favicon
  file { "${app_dir}favicon.ico":
    owner => www-data,
    group => www-data,
    mode => 755,
    source  => "puppet:///modules/fastcgi/favicon.ico",
  }

  # add lesscoding_wp Nginx config
  file { "/etc/nginx/sites-available/lesscoding_wp.conf":
    ensure => file,
    owner   => root,
    group   => root,
    mode    => 644,
    content  => template("fastcgi/lesscoding_wp.conf.erb"),
    require => Package["nginx"],
  }

  # create symbolic link from sites-enabled to our someapp.conf file
  file { "/etc/nginx/sites-enabled/lesscoding_wp":
    ensure => 'link',
    target => '/etc/nginx/sites-available/lesscoding_wp.conf',
    require => File["/etc/nginx/sites-available/lesscoding_wp.conf"],
  }

  # php-fastcgi configuration file
  file { "/usr/bin/php-fastcgi":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/fastcgi/php-fastcgi",
    require => File["/etc/nginx/sites-enabled/lesscoding_wp"],
  }

  # php-fastcgi configuration file
  file { "/etc/init.d/php-fastcgi":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/fastcgi/php-fastcgi.d",
    require => File["/usr/bin/php-fastcgi"],
  }

  # TODO remove this temporary content
  file { "${app_dir}index.php":
    owner   => 'www-data',
    group   => 'www-data',
    mode    => 755,
    content  => "<?php phpinfo(); ?>",
    require => File["/usr/bin/php-fastcgi"],
  }

  # TODO check running
  # chmod +x /etc/init.d/php-fastcgi
  # update-rc.d php-fastcgi defaults
  # /etc/init.d/php-fastcgi start
  # /etc/init.d/nginx start
  # ensure that php-fastcgi is on and running
  service { "php-fastcgi":
    ensure => running,
    enable => true,
    name => 'php-fastcgi',
    path => '/etc/init.d/',
    subscribe => File['/usr/bin/php-fastcgi', '/etc/init.d/php-fastcgi', '/etc/nginx/sites-available/lesscoding_wp.conf'],
  }

}
