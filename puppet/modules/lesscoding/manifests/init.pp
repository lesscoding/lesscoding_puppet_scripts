class lesscoding {

  file { "/etc/nginx/sites-available/lesscoding.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/lesscoding/lesscoding.conf",
    require => Package["nginx"],
  }

  # create symbolic link from sites-enabled to our someapp.conf file
  file { "/etc/nginx/sites-enabled/lesscoding":
    ensure => 'link',
    target => '/etc/nginx/sites-available/lesscoding.conf',
    require => File["/etc/nginx/sites-available/lesscoding.conf"],
  }

  # TODO remove this temporary content
  exec {
    "touch_index":
      command => 'touch /var/www/lesscoding/current/public/index.html; echo "<h1>hello world</h1>" > /var/www/lesscoding/current/public/index.html'
  }

}
