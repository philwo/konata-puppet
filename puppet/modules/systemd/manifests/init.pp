class systemd {
  file { '/etc/systemd':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
  }

  file { '/etc/systemd/system.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/systemd/system.conf'
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
    target => '/usr/lib/systemd/system/multi-user.target',
  }

  # New systemd-journal log
  file { '/var/log/journal':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
  }

  # Old, unneeded log files
  file { '/var/log/auth.log':
    ensure => absent
  }

  file { '/var/log/boot':
    ensure => absent
  }

  file { '/var/log/crond.log':
    ensure => absent
  }

  file { '/var/log/daemon.log':
    ensure => absent
  }

  file { '/var/log/dmesg.log':
    ensure => absent
  }

  file { '/var/log/errors.log':
    ensure => absent
  }

  file { '/var/log/everything.log':
    ensure => absent
  }

  file { '/var/log/faillog':
    ensure => absent
  }

  file { '/var/log/kernel.log':
    ensure => absent
  }

  file { '/var/log/messages.log':
    ensure => absent
  }

  file { '/var/log/postgresql.log':
    ensure => absent
  }

  file { '/var/log/sa':
    ensure => absent
  }

  file { '/var/log/syslog.log':
    ensure => absent
  }

  file { '/var/log/user.log':
    ensure => absent
  }
}
