class nagios::nrpe::ubuntu inherits nagios::nrpe::base {


    Package["nagios-nrpe-server"] { name => "nagios-nrpe-server" }
    Package["nagios-plugins-basic"] { name => "nagios-plugins" }

    Service['nagios-nrpe-server'] { name => 'nagios-nrpe-server' }

}
