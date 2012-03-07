class sudo {
  file { '/etc/sudoers':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0440',
    source => 'puppet:///modules/sudo/sudoers'
  }
}
