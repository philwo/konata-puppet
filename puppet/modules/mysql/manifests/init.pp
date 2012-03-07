class mysql {
  package { 'mysql':
    ensure => installed,
  }

  file { '/etc/systemd/system/mysqld.service':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/mysql/mysqld.service',
  }

  file { '/var/run/mysqld':
    ensure => directory,
    owner  => 'mysql',
    group  => 'mysql',
    mode   => '0755',
  }

  file { '/var/lib/mysql':
    ensure => directory,
    owner  => 'mysql',
    group  => 'mysql',
    mode   => '0700',
  }

  file { '/etc/mysql/my.cnf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('mysql/my.cnf'),
    require => Package['mysql'],
    notify  => Service['mysqld'],
  }

  service { 'mysqld':
    ensure     => running,
    name       => 'mysqld.service',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
