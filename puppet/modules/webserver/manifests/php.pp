define webserver::php ($user = $title) {
  package { 'php':
    ensure => present
  }

  package { 'php-cgi':
    ensure => present
  }

  package { 'php-gd':
    ensure => present
  }

  package { 'php-intl':
    ensure => present
  }

  package { 'php-mcrypt':
    ensure => present
  }

  package { 'php-suhosin':
    ensure => present
  }

  package { 'php-pgsql':
    ensure => present
  }

  package { 'php-sqlite':
    ensure => present
  }

  package { 'php-tidy':
    ensure => present
  }

  package { 'php-xsl':
    ensure => present
  }

  package { 'php-pear':
    ensure => present
  }

  package { 'spawn-fcgi':
    ensure => present
  }

  file { '/var/run/php':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { "/etc/php/php-${user}.ini":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('webserver/php.ini'),
    notify  => Service["php-${user}.service"],
  }

  file { "php-${user}.service":
    ensure  => present,
    path    => "/etc/systemd/system/php-${user}.service",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('webserver/php.service'),
    require => [
      Package['php'],
      Package['php-cgi'],
      Package['php-gd'],
      Package['php-intl'],
      Package['php-mcrypt'],
      Package['php-suhosin'],
      Package['php-pgsql'],
      Package['php-sqlite'],
      Package['php-tidy'],
      Package['php-xsl'],
      Package['php-pear'],
      Package['spawn-fcgi'],
      File['/var/run/php'],
      File["/etc/php/php-${user}.ini"],
    ],
    notify  => Service["php-${user}.service"],
  }

  service { "php-${user}.service":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [File["php-${user}.service"]]
  }
}
