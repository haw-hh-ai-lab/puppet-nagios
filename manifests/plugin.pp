#
# add plugin to nagios setup
#
define nagios::plugin (
  $source = 'absent',
  $ensure = present
){

  $path = $::hardwaremodel ? {
      'x86_64' => "/usr/lib64/nagios/plugins/${name}",
      default  => "/usr/lib/nagios/plugins/${name}",
  }

  $real_source = $source ? {
      'absent' => "puppet:///modules/nagios/plugins/${name}",
      default  => "puppet:///modules/${source}"
  }

  file { $name:
    ensure  => $ensure,
    path    => $path,
    source  => $real_source,
    tag     => 'nagios_plugin',
    require => Package['nagios-plugins'],
    owner   => root,
    group   => 0,
    mode    => 0755;
  }
}
