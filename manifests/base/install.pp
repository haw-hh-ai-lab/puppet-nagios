#
#
#
class nagios::base::install {

  include ::nagios::defaults::vars
  include ::nagios::params

    package { 'nagios':
    ensure => present,
    name   => $nagios::params::srv_package,
    alias  => 'nagios',
  }

  service { 'nagios':
    ensure    => running,
    name      => $nagios::params::nagios_service,
    enable    => true,
    hasstatus => $nagios::params::srv_has_status,
    require   => Package['nagios'],
  }

  # TODO: convert me into a template!!!
  # this file should contain all the nagios_puppet-paths:
  #
  # needed infos:
  #   log_file
  #
  #   possibly multiple cfg_file entries
  #   config_dir (puppet controled)
  #   config_dir_debian (extra debian config in /etc/nagios-plugins/config)
  #
  #
  file { 'nagios_main_cfg':
    path   => "${nagios::defaults::vars::int_cfgdir}/nagios.cfg",
    source => "puppet:///modules/nagios/configs/${::operatingsystem}/nagios.cfg",
    notify => Service['nagios'],
    mode   => '0644',
    owner  => root,
    group  => root;
  }


}