#
# set up nsca server
#

class nagios::nsca::server {

  package { 'nsca':
    ensure => installed
  }

  service { 'nsca':
    ensure     => running,
    hasstatus  => false,
    hasrestart => true,
    require    => Package['nsca'],
  }

  file { '/etc/nsca.cfg':
    source => 'puppet:///modules/nagios/nsca/nsca.cfg',
    owner  => 'nagios',
    group  => 'nogroup',
    mode   => '400',
    notify => Service['nsca'],
  }

}
