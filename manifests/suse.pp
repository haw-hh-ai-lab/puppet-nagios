#
# basic setup for suse machines
#

class nagios::suse inherits nagios::base {
  #
  # TODO: what about the packages 'nagios-nsca', 'nagios-www'
  #
  package { [
    'nagios-plugins',
    'nagios-plugins-extras',
    'nagios-plugins-nrpe',
    ]:
    ensure => 'present',
    notify => Service['nagios'],
  }

  if $nagios::allow_external_cmd {
    file { '/var/spool/nagios':
      ensure  => 'directory',
      require => Package['nagios'],
      mode    => 2660,
      owner   => nagios,
      group   => www,
    }
  }
}
