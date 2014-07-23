class squeezelite::params {

  $player_name          = $::hostname
  $soundcard            = undef
  $mac_address          = undef
  $server_ip            = undef
  $auto_play            = false
  $alsa_params          = undef
  $log_file              = undef
  $log_level             = undef
  $install_dependencies = true
  $package_ensure       = 'present'
  $service_enable       = true
  $service_ensure       = 'running'
  $service_manage       = true

  case $::architecture {
    'i386', 'x86': {
      $squeezelite_bin = 'squeezelite-i386'
    }
    'amd64', 'x86_64': {
      $squeezelite_bin = 'squeezelite-x86-64'
    }
    'armv6': {
      $squeezelite_bin = 'squeezelite-armv6'
    }
    'armv6l', 'armv6hf': {
      $squeezelite_bin = 'squeezelite-armv6hf'
    }
    'arm': {
      $squeezelite_bin = 'squeezelite-armv5te'
    }
    default: {
      fail("unknown architecture: $::architecture")
    }
  }

  $download_url = "http://squeezelite-downloads.googlecode.com/git/${squeezelite_bin}"
  $target_bin   = '/usr/local/bin/squeezelite'

}
