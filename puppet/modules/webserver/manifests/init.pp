class webserver {
  package { 'nginx':
    ensure => present
  }

  file { '/etc/nginx/conf/nginx.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/webserver/nginx.conf',
    notify => Service['nginx'],
    require => Package['nginx']
  }

  service { 'nginx':
    name => 'nginx.service',
    ensure => running,
    enable => true,
    hasstatus => true
  }
}
