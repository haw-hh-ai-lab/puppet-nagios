#
# basic setup for ubuntu machines
#

class nagios::ubuntu inherits nagios::base {
  package { [
    'nagios-plugins',
    'nagios-plugins-extra',
    'nagios-nrpe-plugin']:
    ensure => 'present',
    notify => Service['nagios'],
  }

  File['nagios_htpasswd', 'nagios_cgi_cfg'] {
    group => 'www-data'
  }

  file { 'nagios_commands_cfg':
    ensure => present,
    path   => "${nagios::defaults::vars::int_cfgdir}/commands.cfg",
    notify => Service['nagios'],
    mode   => '0644',
    owner  => root,
    group  => root;
  }

  file { "${nagios::defaults::vars::int_cfgdir}/stylesheets":
    ensure  => directory,
    purge   => false,
    recurse => true,
  }

  file { 'nagios_generic_host_cfg':
    ensure => present,
    path   => "${nagios::defaults::vars::int_cfgdir}/conf.d/generic-host_nagios2.cfg",
    notify => Service['nagios'],
    mode   => '0644',
    owner  => root,
    group  => root
  }

  file { 'nagios_generic_service_cfg':
    ensure => present,
    path   => "${nagios::defaults::vars::int_cfgdir}/conf.d/generic-service_nagios2.cfg",
    notify => Service['nagios'],
    mode   => '0644',
    owner  => root,
    group  => root
  }

  if $nagios::allow_external_cmd {
    exec { 'set perm on nagios3/rw':
      command => 'dpkg-statoverride --update --add nagios www-data 2710 /var/lib/nagios3/rw',
      unless  => 'dpkg-statoverride --list | grep -q /var/lib/nagios3/rw',
      path    => [
        '/bin',
        '/usr/sbin'],
    }

    exec { 'dpkg-statoverride --update --add nagios nagios 751 /var/lib/nagios3'
    :
      unless => 'dpkg-statoverride --list | grep -q /var/lib/nagios3',
      path   => [
        '/bin',
        '/usr/sbin'],
    }

  }
}
