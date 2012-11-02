class wordpress {

  $wordpress_archive = "wordpress-3.4.2.zip"
  $wordpress_app_dir = "${app_dir}blog/"

  $phpmysql = $::operatingsystem ? {
    Ubuntu   => php5-mysql,
    CentOS   => php-mysql,
    Debian   => php5-mysql,
    default  => php-mysql
  }

  package { ['unzip']:
    ensure => latest
  }

  file {
    #'wordpress_application_dir':
    #  ensure  =>  directory,
    #  path    => $wordpress_app_dir,
    #  before  =>  File['wordpress_setup_files_dir'];

    'wordpress_setup_files_dir':
      ensure  =>  directory,
      path    =>  "${app_dir}setup_files",
      before  =>  File[
        'wordpress_php_configuration',
        'wordpress_themes',
        'wordpress_plugins',
        'wordpress_installer'
        ];

    'wordpress_installer':
      ensure  =>  file,
      path    =>  "${app_dir}setup_files/${wordpress_archive}",
      notify  =>  Exec['wordpress_extract_installer'],
      source  =>  "puppet:///modules/wordpress/${wordpress_archive}";

    'wordpress_php_configuration':
      ensure     =>  file,
      path       =>  "${wordpress_app_dir}wp-config.php",
      content    =>  template('wordpress/wp-config.php.erb'),
      owner      =>  'www-data',
      group      =>  'www-data',
      mode       =>  775,
      subscribe  =>  Exec['wordpress_extract_installer'];

    'wordpress_themes':
      ensure     => directory,
      path       => "${app_dir}setup_files/themes",
      source     => 'puppet:///modules/wordpress/themes/',
      recurse    => true,
      purge      => true,
      ignore     => '.svn',
      notify     => Exec['wordpress_extract_themes'],
      subscribe  => Exec['wordpress_extract_installer'];

    'wordpress_plugins':
      ensure     => directory,
      path       => "${app_dir}setup_files/plugins",
      source     => 'puppet:///modules/wordpress/plugins/',
      recurse    => true,
      purge      => true,
      ignore     => '.svn',
      notify     => Exec['wordpress_extract_plugins'],
      subscribe  => Exec['wordpress_extract_installer'];
  }

  exec {
    'wordpress_extract_installer':
      command      => "unzip -o\
      ${app_dir}setup_files/${wordpress_archive}\
      -d ${app_dir}",
      refreshonly  => true,
      require      => Package['unzip'],
      user  => www-data,
      group => www-data,
      path         => ['/bin','/usr/bin','/usr/sbin','/usr/local/bin'];

    'wordpress_rename_dir':
      command     => "sudo mv ${app_dir}wordpress/* ${wordpress_app_dir} && sudo rm -rf ${app_dir}wordpress/",
      subscribe   => Exec['wordpress_extract_installer'],
      refreshonly  => true,
      before => Exec['wordpress_extract_themes'];

    'wordpress_extract_themes':
      command      => '/bin/sh -c \'for themeindex in `ls \
      ${app_dir}setup_files/themes/*.zip`; \
      do unzip -o \
      $themeindex -d \
      ${wordpress_app_dir}wp-content/themes/; done\'',
      path         => ['/bin','/usr/bin','/usr/sbin','/usr/local/bin'],
      refreshonly  => true,
      require      => Package['unzip'],
      subscribe    => File['wordpress_themes'];

    'wordpress_extract_plugins':
      command      => '/bin/sh -c \'for pluginindex in `ls \
      ${app_dir}setup_files/plugins/*.zip`; \
      do unzip -o \
      $pluginindex -d \
      ${wordpress_app_dir}wp-content/plugins/; done\'',
      path         => ['/bin','/usr/bin','/usr/sbin','/usr/local/bin'],
      refreshonly  => true,
      require      => Package['unzip'],
      subscribe    => File['wordpress_plugins'];

    'wordpress_permissions':
      command     => "sudo chmod 775 ${wordpress_app_dir}*",
      subscribe   => Exec['wordpress_rename_dir', 'wordpress_extract_plugins'],
  }

}

