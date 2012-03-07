class webserver::python {
  package { 'python2':
    ensure => present
  }

  package { 'python2-distribute':
    ensure => present
  }

  package { 'python2-pip':
    ensure => present
  }

  package { 'python2-virtualenv':
    ensure => present
  }

  file { '/usr/bin/pip':
    ensure => link,
    target => '/usr/bin/pip2'
  }
}
