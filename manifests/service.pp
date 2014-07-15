class squeezelite::service inherits squeezelite {

  if $service_manage and $package_ensure != 'absent' {
    service {'squeezelite':
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => File['/usr/local/bin/squeezelite'],
    }
  }

}
