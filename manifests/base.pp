# # class nagios::base -- sets basic configuration elements.
#
# Parameter
#=========
#
#   auth_type: can either be 'file'  (default) or 'ldap' to control how
#   authentication should be handled.
#
class nagios::base (
  $auth_type = 'file') {


  # include the variables
  include nagios::defaults::vars
  include nagios::params

  if defined(Service['nagios-nrpe-server']) {
    fail('installing nrpe and nagios on the same node is not supported.')
  }


  include ::nagios::base::install

  case $auth_type {
    'file'  : {
      file { 'nagios_htpasswd':
        path   => "${nagios::defaults::vars::int_cfgdir}/htpasswd.users",
        source => [
          'puppet:///modules/site_nagios/htpasswd.users',
          'puppet:///modules/nagios/htpasswd.users'],
        mode   => '0640',
        owner  => root,
        group  => $::apache::params::group;
      }
    }
    'ldap'  : {
    }
    default : {
      fail("auth type '${auth_type}' not known")
    }
  }

  file { 'nagios_private':
    ensure  => directory,
    path    => "${nagios::defaults::vars::int_cfgdir}/private/",
    purge   => true,
    recurse => true,
    notify  => Service['nagios'],
    mode    => '0750',
    owner   => root,
    group   => nagios;
  }

  file { 'nagios_private_resource_cfg':
    path   => "${nagios::defaults::vars::int_cfgdir}/private/resource.cfg",
    source => [
      "puppet:///modules/site_nagios/configs/${::operatingsystem}/private/resource.cfg.${::architecture}",
      "puppet:///modules/nagios/configs/${::operatingsystem}/private/resource.cfg.${::architecture}"
      ],
    notify => Service['nagios'],
    owner  => root,
    group  => nagios,
    mode   => '0640';
  }

  file { 'nagios_confd':
    ensure  => directory,
    path    => "${nagios::defaults::vars::int_cfgdir}/conf.d/",
    purge   => true,
    recurse => true,
    notify  => Service['nagios'],
    mode    => '0750',
    owner   => root,
    group   => nagios;
  }
  Nagios_command <<| |>>
  Nagios_contactgroup <<| |>>
  Nagios_contact <<| |>>
  Nagios_hostdependency <<| |>>
  Nagios_hostescalation <<| |>>
  Nagios_hostextinfo <<| |>>
  Nagios_hostgroup <<| |>>
  Nagios_host <<| |>>
  Nagios_servicedependency <<| |>>
  Nagios_serviceescalation <<| |>>
  Nagios_servicegroup <<| |>>
  Nagios_serviceextinfo <<| |>>
  Nagios_service <<| |>>
  Nagios_timeperiod <<| |>>

  Nagios_command <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_command.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_contact <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_contact.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_contactgroup <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_contactgroup.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_host <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_host.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_hostdependency <| |> {
    target => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_hostdependency.cfg",
    notify => Service['nagios'],
  }
  Nagios_hostescalation <| |> {
    target => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_hostescalation.cfg",
    notify => Service['nagios'],
  }
  Nagios_hostextinfo <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_hostextinfo.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_hostgroup <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_hostgroup.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_service <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_service.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_servicegroup <| |> {
    target => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_servicegroup.cfg",
    notify => Service['nagios'],
  }
  Nagios_servicedependency <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_servicedependency.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_serviceescalation <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_serviceescalation.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_serviceextinfo <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_serviceextinfo.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }
  Nagios_timeperiod <| |> {
    target  => "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_timeperiod.cfg",
    require => File['nagios_confd'],
    notify  => Service['nagios'],
  }

  file { [
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_command.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_contact.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_contactgroup.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_host.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_hostdependency.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_hostescalation.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_hostextinfo.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_hostgroup.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_hostgroupescalation.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_service.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_servicedependency.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_serviceescalation.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_serviceextinfo.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_servicegroup.cfg",
    "${nagios::defaults::vars::int_cfgdir}/conf.d/nagios_timeperiod.cfg"]:
    ensure  => file,
    replace => false,
    notify  => Service['nagios'],
    mode    => '0644',
    owner   => root,
    group   => 0;
  }

  # manage nagios cfg files
  # must be defined after exported resource overrides and cfg file defs
  file { 'nagios_cfgdir':
    ensure  => directory,
    path    => "${nagios::defaults::vars::int_cfgdir}/",
    recurse => true,
    purge   => true,
    notify  => Service['nagios'],
    mode    => '0755',
    owner   => root,
    group   => root;
  }
}
