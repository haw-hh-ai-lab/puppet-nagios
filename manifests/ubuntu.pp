class nagios::ubuntu inherits nagios::base {

#
# TODO: what about the packages 'nagios-nsca', 'nagios-www'
#
    package { [ 'nagios-plugins', 'nagios-plugins-extra']:
        ensure => 'present',
        notify => Service['nagios'],
    }

    Service[nagios]{
        hasstatus => true,
    }

    File['nagios_htpasswd', 'nagios_cgi_cfg'] { group => 'www-data' }

    file { 'nagios_commands_cfg':
	path   => "${nagios::defaults::vars::int_cfgdir}/commands.cfg",
	ensure => present,
	notify => Service['nagios'],
	mode   => 0644, owner => root, group => root;
    }

    file { "${nagios::defaults::vars::int_cfgdir}/stylesheets":
        ensure => directory,
        purge => false,
        recurse => true,
    }

    file { 'nagios_generic_host_cfg':
	path  => "${nagios::defaults::vars::int_cfgdir}/conf.d/generic-host_nagios2.cfg",
	ensure => present,
	notify => Service['nagios'],
	mode   => 0644, owner => root, group => root
    }

    file { 'nagios_generic_service_cfg':
        path  => "${nagios::defaults::vars::int_cfgdir}/conf.d/generic-service_nagios2.cfg",
        ensure => present,
        notify => Service['nagios'],
        mode   => 0644, owner => root, group => root
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
