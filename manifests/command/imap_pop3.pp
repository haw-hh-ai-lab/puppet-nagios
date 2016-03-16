class nagios::command::imap_pop3 {

  include ::nagios::base::install

  case $::operatingsystem {
    'debian', 'ubuntu' : { # Debian/Ubuntu already define those checks
      }
    default            : {
      nagios_command { 'check_imap':
        command_line => '$USER1$/check_imap -H $ARG1$ -p $ARG2$',
        require      => Package['nagios'];
      }
    }
  }

  nagios_command { 'check_imap_ssl':
    command_line => '$USER1$/check_imap -H $ARG1$ -p $ARG2$ -S',
  }

  nagios_command { 'check_pop3':
    command_line => '$USER1$/check_pop -H $ARG1$ -p $ARG2$',
  }

  nagios_command { 'check_pop3_ssl':
    command_line => '$USER1$/check_pop -H $ARG1$ -p $ARG2$ -S',
  }

  nagios_command { 'check_managesieve':
    command_line => '$USER1$/check_tcp -H $ARG1$ -p 2000',
  }
}
