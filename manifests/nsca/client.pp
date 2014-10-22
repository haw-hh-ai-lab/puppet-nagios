#
# set up nsca client
#
class nagios::nsca::client {

  package { 'nsca': ensure => installed }

  file { '/etc/send_nsca.cfg':
    source => 'puppet:///modules/nagios/nsca/send_nsca.cfg',
    owner  => 'nagios',
    group  => 'nogroup',
    mode   => '0400',
  }

}
