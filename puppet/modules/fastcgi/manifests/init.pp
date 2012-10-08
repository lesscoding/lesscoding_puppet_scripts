class fastcgi {

  # set fastcgi user as www-data
  file {
    ["/var/www/lesscoding_wp/",
     "/var/www/lesscoding_wp/logs/",
     "/var/www/lesscoding_wp/public_html/" ]:
       ensure => directory,
       owner => www-data,
       group => www-data,
       mode => 775,
  }

  # add lesscoding_wp Nginx config
  file { "/etc/nginx/sites-available/lesscoding_wp.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/fastcgi/lesscoding_wp.conf",
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
  exec {
    "touch_test_php":
      command => 'touch /var/www/lesscoding_wp/public_html/test.php; echo "<?php phpinfo(); ?>" > /var/www/lesscoding_wp/public_html/test.php',
      user => 'www-data',
      group => 'www-data',
      require => File['/etc/init.d/php-fastcgi'],
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
    require => Exec['touch_test_php'],
  }

}
