class postfix {
  package { 'postfix':
    ensure => installed
  }

  file { '/etc/systemd/system/postfix.service':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/postfix/postfix.service',
  }

  file { '/etc/postfix/main.cf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('postfix/main.cf'),
    notify  => Service['postfix'],
  }

  file { '/etc/postfix/master.cf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('postfix/master.cf'),
    notify  => Service['postfix'],
  }

  service { 'postfix':
    ensure => running,
    name => 'postfix.service',
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => [
      File['/etc/systemd/system/postfix.service'],
      File['/etc/postfix/main.cf'],
      File['/etc/postfix/master.cf']
    ]
  }
}
