class nagios::nrpe::suse inherits nagios::nrpe::base {

#    package { "libwww-perl": ensure => present;   # for check_apache
#        }

    Package["nagios-nrpe-server"] { name => "nrpe" }
    Package["nagios-plugins-basic"] { name => "nagios-plugins" }

    # Special-case lenny. the package doesn't exist
#    if $lsbdistcodename != 'lenny' {
#        package { "libnagios-plugin-perl": ensure => present; }
#    }
    

    package {
        "ksh": ensure => present; # for check_cpustats.sh
        "sysstat": ensure => present; # for check_cpustats.sh
    }

}
