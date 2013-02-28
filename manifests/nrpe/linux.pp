class nagios::nrpe::linux inherits nagios::nrpe::base {

    package { "libwww-perl": ensure => present;   # for check_apache
        }

    # Special-case lenny. the package doesn't exist
    if $lsbdistcodename != 'lenny' {
        package { "libnagios-plugin-perl": ensure => present; }
    }
    

    package {
        "nagios-plugins-standard": ensure => present;
        "ksh": ensure => present; # for check_cpustats.sh
        "sysstat": ensure => present; # for check_cpustats.sh
    }

}
