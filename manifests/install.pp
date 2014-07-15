class squeezelite::install inherits squeezelite {

  if $package_ensure != 'absent' {

    if $install_dependencies {
      # the following dependencies are required to run squeezelite
      # make sure to install them
      # prevent duplicate resrouce definitions
      ensure_packages([
        'libpng12-0',
        'libflac-dev',
        'libfaad2',
        'libmad0',
        'libasound2',
	'wget',
      ])
      # package {'alsa-utils': ensure => 'present', }
    }

    exec {'get-squeezelite':
      command => "/usr/bin/wget '${download_url}' -O '/tmp/$squeezelite_bin' && /bin/mv '/tmp/$squeezelite_bin' '${target_bin}'",
      unless  => $test_cmd,
      before  => File['/usr/local/bin/squeezelite'],
    }
  }

  file {'/usr/local/bin/squeezelite':
    ensure  => $file_ensure,
    owner   => 'root',
    mode    => '0755',
  }

}
