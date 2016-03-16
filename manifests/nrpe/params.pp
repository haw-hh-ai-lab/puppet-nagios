#
# configure params for various OS types
#

class nagios::nrpe::params {

  case $::operatingsystem {
    'FreeBSD'          : {
      $default_nrpe_cfgdir = '/usr/local/etc'
      $default_nrpe_pid_file = '/var/spool/nagios/nrpe2.pid'
      $default_plugin_dir = '/usr/local/libexec/nagios'
    }
    'SLES'             : {
      $default_nrpe_cfgdir = '/etc/nagios'
      $default_nrpe_pid_file = '/var/run/nrpe.pid'
      $default_plugin_dir = '/usr/lib/nagios/plugins'
    }
    'Debian', 'Ubuntu' : {
      $default_nrpe_cfgdir = '/etc/nagios'
      $default_nrpe_pid_file = '/var/run/nagios/nrpe.pid'
      $default_plugin_dir = '/usr/lib/nagios/plugins'
    }
    default            : {
      $default_nrpe_cfgdir = '/etc/nagios/nrpe'
      $default_nrpe_pid_file = '/var/run/nrpe.pid'
      $default_plugin_dir = '/usr/lib/nagios/plugins'
    }
  }
}
