#
# nagios module
# nagios.pp - everything nagios related
#
# do not call this module directly. Either choose a supported web server (like
# nagios::apache or nagios::lighttpd) or the nagios::headless module for a
# nagios server without a web frontend.
#
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Haerry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
# Copyright 2014 Lutz Behnke <lutz.behnke@informatik.haw-hamburg.de>
#
# This program is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License version 3 as published by
# the Free Software Foundation.
#

# manage nagios
class nagios(
  $allow_external_cmd = false,
  $manage_shorewall = false,
  $manage_munin = false,
  $httpd_service_name = undef,
) {

  case $::operatingsystem {
    'centos': {
      $cfgdir = '/etc/nagios'
      include nagios::centos
    }
    'debian': {
      $cfgdir = '/etc/nagios3'
      include nagios::debian
    }
    'SLES': {
      $cfgdir = '/etc/nagios'
      include nagios::suse
    }
    'Ubuntu': {
      $cfgdir = '/etc/nagios3'
      include nagios::ubuntu
    }
    default: {
      fail("No such operatingsystem: ${::operatingsystem} defined yet")
    }
  }

  if $manage_munin {
    include nagios::munin
  }

  # additional commands
  include nagios::command::nrpe


}
