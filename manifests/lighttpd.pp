#
# deploy nagios web server on ligthttpd
#

class nagios::lighttpd(
  $allow_external_cmd = false,
  $manage_shorewall = false,
  $manage_munin = false
) {
  include ::nagios::params

  include ::lighttpd

  # TODO: convert me into a template!!!
  file { 'nagios_cgi_cfg':
    path   => "${nagios::defaults::vars::int_cfgdir}/cgi.cfg",
    source => [
      "puppet:///modules/nagios/configs/${::operatingsystem}/cgi.cfg",
      'puppet:///modules/nagios/configs/cgi.cfg'],
    mode   => '0644',
    owner  => 'root',
    group  => $::nagios::params::web_group,
    notify => Service[$nagios::httpd_service_name],
  }

  class{'nagios':
    allow_external_cmd => $allow_external_cmd,
    manage_munin => $manage_munin,
    manage_shorewall => $manage_shorewall,
  }
}
