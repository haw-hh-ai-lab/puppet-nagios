#
# do additional settings for checking imap service
#

define nagios::service::imap (
  $ensure   = 'present',
  $host     = 'absent',
  $port     = '143',
  $tls      = true,
  $tls_port = '993') {
  $real_host = $host ? {
    'absent' => $name,
    default  => $host
  }

  nagios::service { "imap_${name}_${port}":
    ensure => $ensure,
  }

  $imaps_ensure = $tls ? {
    true    => $ensure,
    default => 'absent'
  }

  nagios::service { "imaps_${name}_${tls_port}":
    ensure => $imaps_ensure,
  }

  if $ensure != 'absent' {
    Nagios::Service["imap_${name}_${port}"] {
      check_command => "check_imap!${real_host}!${port}",
    }

    Nagios::Service["imaps_${name}_${tls_port}"] {
      check_command => "check_imap_ssl!${real_host}!${tls_port}",
    }
  }
}
