# == Class: squeezelite
#
# Manage squeezelite player with puppet.
# This class installs the package and service to run the player.
#
# === Parameters
#
# player_name
#   player name shown in logitech media server
#   optional, defaults to hostname
#
# soundcard
#   Set the soundcard
#   example: "sysdefault:CARD=ALSA"
#   optional
#
# mac_address
#   Change the mac address
#     Note: when left commented squeezelite will use the mac address of your
#     ethernet card or wifi adapter, which is what you want.
#     If you change it to something different, it will give problems is you
#     use mysqueezebox.com.
#   optional
#
# server_ip
#   Change the IP address of your squeezebox server
#   optional
#
# auto_play
#   Start playing when starting the service
#   optional, defaults to false
#
# alsa_params
#   Set ALSA parameters
#   example: "80"
#   optional
#
# log_file
#   path to a log file
#   only useful in combination with log_level
#   optional
#
# log_level
#   example: "all=debug"
#   only useful in combination with log_file
#   optional
#
# === Examples
#
#  class { squeezelite:
#    player_name => 'booooooombox',
#  }
#
# === Authors
#
# Author Name <f@ub0r.de>
#
# === Copyright
#
# Copyright 2014 Felix Bechstein
#
class squeezelite (
  $player_name          = $squeezelite::params::player_name,
  $soundcard            = $squeezelite::params::soundcard,
  $mac_address          = $squeezelite::params::mac_address,
  $server_ip            = $squeezelite::params::server_ip,
  $auto_play            = $squeezelite::params::auto_play,
  $alsa_params          = $squeezelite::params::alsa_params,
  $log_file              = $squeezelite::params::log_file,
  $log_level             = $squeezelite::params::log_level,
  $install_dependencies = $squeezelite::params::install_dependencies,
  $package_ensure       = $squeezelite::params::package_ensure,
  $service_enable       = $squeezelite::params::service_enable,
  $service_ensure       = $squeezelite::params::service_ensure,
  $service_manage       = $squeezelite::params::service_manage,

) inherits squeezelite::params {

  validate_string($player_name)
  validate_bool($auto_play)
  validate_bool($install_dependencies)
  validate_string($package_ensure)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)

  case $package_ensure {
    'latest': {
      # ignore existing binary
      $file_ensure = 'file'
      $test_cmd    = '/bin/false'
    }
    'present': {
      # keep existing binary
      $file_ensure = 'file'
      $test_cmd    = "/usr/bin/test -e ${target_bin}"
    }
    'absent': {
      # skip download of binary
      $file_ensure = 'absent'
      $test_cmd    = '/bin/true'
    }
    default: {
      fail('unsupported value for $package_ensure')
    }
  }

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor  { 'squeezelite::begin': } ->
  class { '::squeezelite::install': } ->
  class { '::squeezelite::config': } ~>
  class { '::squeezelite::service': } ->
  anchor  { 'squeezelite::end': }

}
