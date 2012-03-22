class linux {
  file { '/etc/mkinitcpio.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/linux/mkinitcpio.conf'
  }

  exec { 'mkinitcpio':
    path => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    command => 'mkinitcpio -p linux',
    subscribe => File['/etc/mkinitcpio.conf'],
    refreshonly => true
  }

  file { '/etc/fstab':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/linux/fstab',
  }

  file { '/etc/hosts':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/linux/hosts',
  }

  file { '/etc/resolv.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/linux/resolv.conf',
  }

  file { '/etc/locale.gen':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/linux/locale.gen'
  }

  exec { 'locale-gen':
    path => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    subscribe => File['/etc/locale.gen'],
    refreshonly => true
  }

  file { '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/Asia/Tokyo'
  }
}
