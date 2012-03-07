define users::user (
    $uid,
    $username = $title,
    $groups = ['users'],
    $fullname = undef,
    $email = undef,
    $ssh_key = undef,
    $has_git = false,
    $has_www = true
  ) {
  include users

  if $uid == undef {
    fail('Please specify an explicit ID for user ${username}.')
  }

  ### HOMEDIR

  if $username == 'root' {
    $home = "/root"
    $home_mode = '0700'
  } else {
    $home = "/home/${username}"
    $home_mode = '0755'
  }

  group { $username:
    ensure => present,
    gid    => $uid,
  }

  user { $username:
    ensure => present,
    uid    => $uid,
    gid    => $username,
    groups => $groups,
    home   => $home,
    shell  => '/bin/bash',
  }

  file { "${home}":
    ensure  => directory,
    owner   => $username,
    group   => $username,
    mode    => $home_mode,
  }

  file { "${home}/.bashrc":
    ensure  => file,
    owner   => $username,
    group   => $username,
    mode    => '0600',
    source  => 'puppet:///modules/users/bashrc',
  }

  file { "${home}/.bash_profile":
    ensure  => file,
    owner   => $username,
    group   => $username,
    mode    => '0600',
    source  => 'puppet:///modules/users/bash_profile',
  }

  file { "${home}/.vimrc":
    ensure  => file,
    owner   => $username,
    group   => $username,
    mode    => '0644',
    source  => 'puppet:///modules/users/vimrc',
  }

  ### GIT

  if $has_git == true {
    if $fullname == undef or $email == undef {
      fail('Please specify the full name and e-mail address for user ${username}.')
    }

    file { "${home}/.gitconfig":
      ensure  => file,
      owner   => $username,
      group   => $username,
      mode    => '0600',
      content => template('users/gitconfig'),
    }
  }

  ### SSH

  if $ssh_key != undef {
    file { "${home}/.ssh":
      ensure  => directory,
      owner   => $username,
      group   => $username,
      mode    => '0755',
    }

    file { "${home}/.ssh/authorized_keys":
      ensure  => file,
      owner   => $username,
      group   => $username,
      mode    => '0644',
    }

    ssh_authorized_key { "${username}-rsa":
      ensure  => present,
      key     => $ssh_key,
      type    => 'ssh-rsa',
      user    => $username,
      require => File["${home}/.ssh/authorized_keys"],
    }
  } else {
    file { "${home}/.ssh/authorized_keys":
      ensure  => absent,
    }
  }

  ### WEBHOSTING

  if $has_www == true {
    file { "${home}/www":
      ensure  => directory,
      owner   => $username,
      group   => $username,
      mode    => '0755',
    }
  }
}
