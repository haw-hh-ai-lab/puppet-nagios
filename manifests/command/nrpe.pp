#
# define basic nrpe check command
#
class nagios::command::nrpe {

  case $::operatingsystem {
    'Debian', 'Ubuntu': { # Debian/Ubuntu already define those checks

      nagios_command { 'check_nrpe':
        ensure => absent
      }

      nagios_command { 'check_nrpe_1arg':
        ensure => absent
      }
    }
    default: {

      # this command runs a program $ARG1$ with arguments $ARG2$ via the NRPE mechanism
      nagios_command { 'check_nrpe':
        command_line => '/usr/lib/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$ -a $ARG2$',
      }

      # this command runs a program $ARG1$ with no arguments
      nagios_command { 'check_nrpe_1arg':
        command_line => '/usr/lib/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$',
      }

    }
  }



  #
  # define command for nrpe checks with additional timeout
  #
  nagios_command { 'check_nrpe_timeout':
    command_line => '/usr/lib/nagios/plugins/check_nrpe -t $ARG1$ -H $HOSTADDRESS$ -c $ARG2$ -a $ARG3$',
  }

  nagios_command { 'check_nrpe_1arg_timeout':
    command_line => '/usr/lib/nagios/plugins/check_nrpe -t $ARG1$ -H $HOSTADDRESS$ -c $ARG2$',
  }
}
