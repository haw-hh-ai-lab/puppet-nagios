#
#
#
class nagios::rsp_test {

  file{ '/tmp/dummy':
    content => 'a dummy, really',
  }

    nagios_command {'check_imap_ssl':
      command_line => '$USER1$/check_imap -H $ARG1$ -p $ARG2$ -S',
      require      => Package['nagios-plugins'];
  }
}
