class nagios::nrpe::base {

    if $nagios_nrpe_cfgdir == '' { $nagios_nrpe_cfgdir = '/etc/nagios' }
    if $processorcount == '' { $processorcount = 1 }
    
    package { "nagios-nrpe-server": ensure => present;
		      "nagios-plugins-basic": ensure => present;
	    }

    file { [ $nagios_nrpe_cfgdir, "$nagios_nrpe_cfgdir/nrpe.d" ]: 
	ensure => directory }

    if $nagios_nrpe_dont_blame == '' { $nagios_nrpe_dont_blame = 1 }
    file { "$nagios_nrpe_cfgdir/nrpe.cfg":
	    content => template('nagios/nrpe/nrpe.cfg'),
	    owner => root, group => 0, mode => 644;
    }
    
    # add some default commands
    # FIXME: currently all commands in this file are commented out, as they use args.
    nagios::nrpe::command { "basic_nrpe":
        source => [ "puppet:///modules/site-nagios/configs/nrpe/nrpe_commands.${fqdn}.cfg",
                    "puppet:///modules/site-nagios/configs/nrpe/nrpe_commands.cfg",
                    "puppet:///modules/nagios/nrpe/nrpe_commands.cfg" ],
    }
    
    # FIXME: this is far to general to be usefull.
    # the check for load should be customized for each server based on number
    # of CPUs and the type of activity. Get number of processors from facter
    #$warning_1_threshold = 7 * $::processorcount
    #$warning_5_threshold = 6 * $::processorcount
    #$warning_15_threshold = 5 * $::processorcount
    #$critical_1_threshold = 10 * $::processorcount
    #$critical_5_threshold = 9 * $::processorcount
    #$critical_15_threshold = 8 * $::processorcount
    #nagios::nrpe::command { "check_load":
    #    command_line => "${nagios_plugin_dir}/check_load -w ${warning_1_threshold},${warning_5_threshold},${warning_15_threshold} -c ${critical_1_threshold},${critical_5_threshold},${critical_15_threshold}",
    #}

    service { "nagios-nrpe-server":
	    ensure    => running,
	    enable    => true,
	    pattern   => "nrpe",
	    subscribe => File["$nagios_nrpe_cfgdir/nrpe.cfg"],
            require   => Package["nagios-nrpe-server"],
    }
}
