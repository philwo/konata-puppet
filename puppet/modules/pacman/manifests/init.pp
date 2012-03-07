class pacman {
  package { 'pacman':
    ensure => installed
  }

  file { '/etc/pacman.d':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755'
  }

  file { '/etc/pacman.d/mirrorlist':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/pacman/mirrorlist'
  }
}
