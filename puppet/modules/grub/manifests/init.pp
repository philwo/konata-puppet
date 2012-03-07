class grub {
  package { 'grub':
    ensure => installed
  }

  file { '/boot/grub':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
  }

  file { '/boot/grub/menu.lst':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/grub/menu.lst'
  }
}
