#
# configure nrpe daemon on suse machine
#

class nagios::nrpe::suse inherits nagios::nrpe::base {

#    package { "libwww-perl": ensure => present;   # for check_apache
#        }

    Package["nagios-nrpe-server"] { name => "nagios-nrpe" }
    Package["nagios-plugins-basic"] { name => "nagios-plugins" }


    package {
        "ksh": ensure => present; # for check_cpustats.sh
        "sysstat": ensure => present; # for check_cpustats.sh
    }

    Service['nagios-nrpe-server'] { name => 'nrpe' }

}
