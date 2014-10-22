#
# set package names for centos and add OS specific settings
#
class nagios::centos (
  $auth_type = 'file',
) inherits nagios::base {

  package { [
    'nagios-plugins',
    'nagios-plugins-smtp',
    'nagios-plugins-http',
    'nagios-plugins-ssh',
    'nagios-plugins-tcp',
    'nagios-plugins-dig',
    'nagios-plugins-nrpe',
    'nagios-plugins-load',
    'nagios-plugins-dns',
    'nagios-plugins-ping',
    'nagios-plugins-procs',
    'nagios-plugins-users',
    'nagios-plugins-ldap',
    'nagios-plugins-disk',
    'nagios-plugins-swap',
    'nagios-plugins-nagios',
    'nagios-plugins-perl',
    'nagios-plugins-ntp',
    'nagios-plugins-snmp']:
    ensure => 'present',
    notify => Service['nagios'],
  }

  if $nagios::allow_external_cmd {
    file { '/var/spool/nagios/cmd':
      ensure  => 'directory',
      require => Package['nagios'],
      mode    => '2660',
      owner   => apache,
      group   => nagios,
    }
  }
}
