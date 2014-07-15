class squeezelite::config inherits squeezelite {

  file {'/etc/init.d/squeezelite':
    ensure  => $file_ensure,
    owner   => 'root',
    mode    => '0755',
    content => template('squeezelite/init.d_squeezelite.erb'),
  }

  file {'/etc/default/squeezelite':
    ensure  => $file_ensure,
    owner   => 'root',
    mode    => '0755',
    content => template('squeezelite/default_squeezelite.erb'),
  }

}
