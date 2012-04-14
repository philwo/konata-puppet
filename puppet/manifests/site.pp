# Puppet manifest
# for konata.philwo.de

Service {
  provider => 'systemd',
}

node default {
  class { 'linux': }
  class { 'systemd': }
  class { 'systemd::network': }
  class { 'grub': }

  class { 'pacman': }
  class { 'ntp': }
  class { 'sudo': }

  users::user { 'root':
    uid     => 0,
    groups  => ['root', 'bin', 'daemon', 'sys', 'adm', 'disk', 'wheel', 'log'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDPpbil2BQz7x9rSddrEQ5PrzRSf+zyyJd4jlYHj2kP+5tvqnOuSTRgZIuhA2LEIRP89Zsnhn31gFyewkws3OFUqBTsPFtgcN31lFGagkVU2bSLIVB1NtB89WyjviTY69rjDhWST/KywJLLgQFvTfWngKOZTiHmKKEuK+HwdQUGxrH99mNDyEbZh39p0s4CmvZslUIi1NJkfMDHVS2q5c8g5VFU8lC7AeTDI+I5ozz0B4NygnHVI9egNMkoYhhh0op9UNPQnk+dxV6KEwWNnY2RyfApHZ4V1rEMq6WhQWuEiY6Kyy9YoZKu9iskHKuodgscs2M0kLGl6jnRc9Edj4pH',
    has_git => false,
    has_www => false,
  }

  users::user { 'philwo':
    uid      => 1000,
    fullname => 'Philipp Wollermann',
    email    => 'philipp.wollermann@gmail.com',
    groups   => ['users', 'wheel'],
    ssh_key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDPpbil2BQz7x9rSddrEQ5PrzRSf+zyyJd4jlYHj2kP+5tvqnOuSTRgZIuhA2LEIRP89Zsnhn31gFyewkws3OFUqBTsPFtgcN31lFGagkVU2bSLIVB1NtB89WyjviTY69rjDhWST/KywJLLgQFvTfWngKOZTiHmKKEuK+HwdQUGxrH99mNDyEbZh39p0s4CmvZslUIi1NJkfMDHVS2q5c8g5VFU8lC7AeTDI+I5ozz0B4NygnHVI9egNMkoYhhh0op9UNPQnk+dxV6KEwWNnY2RyfApHZ4V1rEMq6WhQWuEiY6Kyy9YoZKu9iskHKuodgscs2M0kLGl6jnRc9Edj4pH',
    has_git  => true,
    has_www  => true,
  }

  users::user { 'ch':
    uid => 1001,
  }

  class { 'mysql': }
  class { 'postgresql': }
  class { 'postfix': }
  class { 'webserver': }

  webserver::django { 'philwo.de':
    path     => '/home/philwo/www/philwo.de/philwo',
    user     => 'philwo',
    settings => 'philwo.settings',
  }

  webserver::django { 'knmc.philwo.de':
    path     => '/home/philwo/www/knmc.philwo.de/knmc',
    user     => 'philwo',
    settings => 'knmc.settings',
  }

  webserver::php { 'ch': }
}
