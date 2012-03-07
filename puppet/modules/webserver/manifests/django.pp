define webserver::django ($path, $user) {
  include webserver::python

  file { "django-${title}.service":
    ensure  => present,
    path    => "/etc/systemd/system/django-${title}.service",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('webserver/django.service'),
    notify  => Service["django-${title}.service"],
  }

  service { "django-${title}.service":
    ensure  => running,
    enable  => true,
    hasstatus => true,
    hasrestart => true,
    require => [File["django-${title}.service"]]
  }
}
