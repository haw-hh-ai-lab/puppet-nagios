class nagios::centos inherits nagios::base {

#
# TODO: what about the packages 'nagios-nsca', 'nagios-www'
#
    package { [ 'nagios', 'nagios-plugins', 'nagios-plugin-extras', 'nagios-nrpe-client', 'nagios-plugins-nrpe', ]:
        ensure => 'present',
        notify => Service['nagios'],
    }

    Service[nagios]{
        hasstatus => true,
    }

    if $nagios::allow_external_cmd {
        file { '/var/spool/nagios':
            ensure => 'directory',
            require => Package['nagios'],
            mode => 2660, 
            owner => nagios, 
            group => www,
        }
    }
}
