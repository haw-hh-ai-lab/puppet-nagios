#
#  set the check commands for IMAP and POP services.
#
class nagios::command::imap_pop3 {

  case $operatingsystem {
    'debian', 'ubuntu' : { # Debian/Ubuntu already define those checks
      }
    default            : {
      nagios_command { 'check_imap':
        command_line => '$USER1$/check_imap -H $ARG1$ -p $ARG2$',
        require      => Package['nagios-plugins']
      }
    }
  }

  nagios_command {
    'check_imap_ssl':
      command_line => '$USER1$/check_imap -H $ARG1$ -p $ARG2$ -S',
      require      => Package['nagios-plugins'];

    'check_pop3':
      command_line => '$USER1$/check_pop -H $ARG1$ -p $ARG2$',
      require      => Package['nagios-plugins'];

    'check_pop3_ssl':
      command_line => '$USER1$/check_pop -H $ARG1$ -p $ARG2$ -S',
      require      => Package['nagios-plugins'];

    'check_managesieve':
      command_line => '$USER1$/check_tcp -H $ARG1$ -p 2000',
      require      => Package['nagios-plugins'];
  }
}
