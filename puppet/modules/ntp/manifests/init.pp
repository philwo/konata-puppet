class ntp {
  package { 'ntp':
    ensure => installed,
  }

  file { '/etc/ntp.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/ntp/ntp.conf',
    notify  => Service['ntpd'],
    require => Package['ntp'],
  }

  service { 'ntpd':
    ensure     => running,
    name       => 'ntpd.service',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
