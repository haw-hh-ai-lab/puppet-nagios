#
# add pnp4nagios
#

class nagios::pnp4nagios::popup inherits nagios::pnp4nagios {
  File['pnp4nagios-templates.cfg'] {
    source => 'puppet:///modules/nagios/pnp4nagios/pnp4nagios-popup-templates.cfg',
  }

  file { '/usr/share/nagios3/htdocs/ssi':
    ensure => directory
  }

  file { 'status-header.ssi':
    path   => '/usr/share/nagios3/htdocs/ssi/status-header.ssi',
    source => 'puppet:///modules/nagios/pnp4nagios/status-header.ssi',
    mode   => '0644',
    owner  => root,
    group  => root,
    notify => Service['nagios'],
  }
}
