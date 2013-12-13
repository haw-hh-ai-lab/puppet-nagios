#
# setting the class params will overide the global vars.
#
class nagios::nrpe (
   $cfgdir         = $nagios::nrpe::params::default_nrpe_cfgdir,
   $pid_file       = $nagios::nrpe::params::default_nrpe_pid_file,
   $plugin_dir     = $nagios::nrpe::params::default_plugin_dir,
   $allowed_hosts  = [ '127.0.0.1' ],
  ) inherits nagios::nrpe::params {

    $nagios_nrpe_cfgdir = $cfgdir
    $nagios_nrpe_pid_file =  $pid_file
    $nagios_plugin_dir = $plugin_dir
    $nagios_nrpe_allowed_hosts = $allowed_hosts

    case $operatingsystem {
        'FreeBSD': {
            include nagios::nrpe::freebsd
        }
        'SLES': {
            include nagios::nrpe::suse
        }
       'Ubuntu': {
            include nagios::nrpe::ubuntu
        }
        default: {
            case $kernel {
                linux: { include nagios::nrpe::linux }
                default: { include nagios::nrpe::base }
            }
        }
    }

}
