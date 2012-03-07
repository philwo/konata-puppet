class archinit {
  file { '/etc/inittab':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/archinit/inittab'
  }

  file { '/etc/rc.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/archinit/rc.conf'
  }
}
