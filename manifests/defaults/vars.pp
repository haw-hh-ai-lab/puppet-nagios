class nagios::defaults::vars {
  case $nagios::cfgdir {
    '': { $int_cfgdir = $::operatingsystem ? {
            centos => '/etc/nagios/',
            Ubuntu => '/etc/nagios3/',
            default => '/etc/nagios3'
          }
    }
    default: { $int_cfgdir = $nagios::cfgdir }
  }
}
