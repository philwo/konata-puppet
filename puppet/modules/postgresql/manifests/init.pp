class postgresql {
  package { 'postgresql':
    ensure => installed,
  }

  file { '/etc/conf.d/postgresql':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/postgresql/conf.d/postgresql',
  }

  file { '/var/lib/postgres':
    ensure => directory,
    owner  => 'postgres',
    group  => 'postgres',
  }

  #file { '/var/log/postgresql.log':
  #  ensure => file,
  #  owner  => 'postgres',
  #  group  => 'postgres',
  #  mode   => '0644',
  #}

  exec { 'postgresql-initdb':
    command => '/usr/bin/initdb --locale en_US.UTF-8 -D /var/lib/postgres/data',
    creates => '/var/lib/postgres/data',
    user    => 'postgres',
    require => [File['/var/lib/postgres'], Package['postgresql']],
    notify  => Service['postgresql'],
  }

  file { '/var/lib/postgres/data/pg_hba.conf':
    ensure  => file,
    owner   => 'postgres',
    group   => 'postgres',
    mode    => '0600',
    content => template('postgresql/pg_hba.conf'),
    require => Exec['postgresql-initdb'],
    notify  => Service['postgresql'],
  }

  file { '/var/lib/postgres/data/postgresql.conf':
    ensure  => file,
    owner   => 'postgres',
    group   => 'postgres',
    mode    => '0600',
    content => template('postgresql/postgresql.conf'),
    require => Exec['postgresql-initdb'],
    notify  => Service['postgresql'],
  }

  service { 'postgresql':
    ensure     => running,
    name       => 'postgresql.service',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [
      Exec['postgresql-initdb'],
      File['/etc/conf.d/postgresql'],
      File['/var/log/postgresql.log'],
    ],
  }
}
