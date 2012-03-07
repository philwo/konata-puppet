class systemd::network {
  file { '/etc/conf.d/network':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/systemd/conf.d/network'
  }

  file { '/etc/systemd/system/network@.service':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/systemd/system/network@.service'
  }

  file { '/etc/systemd/system/multi-user.target.wants/network@eth0.service':
    ensure => link,
    target => '/etc/systemd/system/network@.service'
  }
}
