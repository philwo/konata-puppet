class systemd {
  file { '/etc/systemd':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
  }

  file { '/etc/systemd/system':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
  }

  file { '/etc/hostname':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => 'konata.philwo.de'
  }

  file { '/etc/vconsole.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/systemd/vconsole.conf'
  }

  file { '/etc/locale.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/systemd/locale.conf'
  }

  file { '/etc/inittab':
    ensure => absent
  }

  file { '/etc/rc.conf':
    ensure => absent
  }

  file { '/etc/systemd/system/default.target':
    ensure => link,
    target => '/lib/systemd/system/multi-user.target',
  }
}
