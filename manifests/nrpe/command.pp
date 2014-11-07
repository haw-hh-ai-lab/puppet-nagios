#
# setup nrpe command
#
# Parameters:
#  - ensure: present or absent to install or de-install commands respectively
#  - command_line: actual command to execute on the targe machine
#  - source: template or file source to use for constructing command fragment
#

define nagios::nrpe::command (
  $ensure       = present,
  $command_line = '',
  $source       = '',
){

  if ($command_line == '' and $source == '') {
    fail("Either one of 'command_line' or 'source' must be given to nagios::nrpe::command."
    )
  }

  if $nagios_nrpe_cfgdir == '' {
    $nagios_nrpe_cfgdir = $nagios::nrpe::base::nagios_nrpe_cfgdir
  }

  file { "${nagios_nrpe_cfgdir}/nrpe.d/${name}_command.cfg":
    ensure  => $ensure,
    mode    => '0644',
    owner   => root,
    group   => 0,
    notify  => Service['nagios-nrpe-server'],
    require => File["${nagios_nrpe_cfgdir}/nrpe.d"]
  }

  case $source {
    ''      : {
      File["${nagios_nrpe_cfgdir}/nrpe.d/${name}_command.cfg"] {
        content => template('nagios/nrpe/nrpe_command.erb'),
      }
    }
    default : {
      File["${nagios_nrpe_cfgdir}/nrpe.d/${name}_command.cfg"] {
        source => $source,
      }
    }
  }
}
