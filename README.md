# squeezelite

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with squeezelite](#setup)
    * [What squeezelite affects](#what-squeezelite-affects)
    * [Beginning with squeezelite](#beginning-with-squeezelite)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and manages the squeezelite package and service.
It's tested on Debian and Ubuntu systems.
Other distribution may need only minor changes for package names.

## Setup

### What squeezelite affects

This package will create three files:

* /usr/local/bin/squeezelite
* /etc/default/squeezelite
* /etc/init.d/squeezelite

### Beginning with squeezelite

`include '::squeezelite'` is enough to get started.
If you wish to pass in parameters specifying the player name, then:

```puppet
class { '::squeezelite':
  player_name => 'boooooooombox',
}
```

## Usage

All interaction with the squeezelite module can be done with the main class.

## Reference

### Classes

#### Public classes

* squeezelite: Main class, includes all other classes

#### Private classes

* squeezelite::install: Handles package install.
* squeezelite::config: Handles configuration and init file.
* squeezelite::service: Handles the service.

###Parameters

##`player_name`

player name shown in logitech media server
optional, defaults to hostname

##`soundcard`

Set the soundcard
example: "sysdefault:CARD=ALSA"
optional

##`mac_address`

Change the mac address
  Note: when left commented squeezelite will use the mac address of your ethernet card or
  wifi adapter, which is what you want.
  If you change it to something different, it will give problems is you use mysqueezebox.com .
optional

##`server_ip`

Change the IP address of your squeezebox server
optional

##`auto_play`

Start playing when starting the service
optional, defaults to false

##`alsa_params`

Set ALSA parameters
example: "80"
optional

##`log_file`

path to a log file
only useful in combination with log_level
optional

##`log_level`

example: "all=debug"
only useful in combination with log_file
optional

## Limitations

This module has been build and tested agains Puppet 3.6 and higher.

The module has been tested on:

* Debian 6/7
* Ubuntu 14.04

## Development

Just fork and send PR on github.
