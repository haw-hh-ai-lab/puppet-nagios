#
#  OS/Distro specific values
#
#  nagios_cfg_dir  = root directory for nagios configuration files.
#  nagios_service  = service name of the nagios server
#  srv_has_status  = the hasstatus feature is availiable for the nagios service.
#  cgi_dir         =
#  cgi_path        =
#  web_dir         = directory where the html files are located
#  srv_package     = package containing the minimal nagios server
#  plugin_packages = additional packages containing the plugins (they may be
#                    included in the base install on some OSes).
#
class nagios::params {
  case $::operatingsystem {
    'debian' : {
      $nagios_cfg_dir = '/etc/nagios3'
      $nagios_service = 'nagios3'
      $srv_has_status = true
      $cgi_dir = '/usr/lib/cgi-bin/nagios3/'
      $cgi_path = '/cgi-bin/nagios3/'
      $web_dir = '/usr/share/nagios3/htdocs/'
      $web_user = 'www-data',
      $web_group = 'www-data'
      $srv_package = 'nagios3'
      $plugin_packages = [
        'nagios-plugins',
        'nagios-snmp-plugins',
        'nagios-nrpe-plugin']
    }
    'Ubuntu' : {
      $nagios_cfg_dir = '/etc/nagios3'
      $nagios_service = 'nagios3'
      $srv_has_status = true
      $cgi_dir = '/usr/lib/cgi-bin/nagios3/'
      $cgi_path = '/cgi-bin/nagios3/'
      $web_dir = '/usr/share/nagios3/htdocs/'
      $web_user = 'www-data'
      $web_group = 'www-data'
      $srv_package = 'nagios3'
      $plugin_packages = [
        'nagios-plugins',
        'nagios-plugins-extra',
        'nagios-nrpe-plugin']
    }
    'SLES'   : {
      $nagios_cfg_dir = '/etc/nagios'
      $nagios_service = 'nagios'
      $srv_has_status = true
      $cgi_dir = '/usr/lib/cgi-bin/nagios3/'
      $cgi_path = '/cgi-bin/nagios3/'
      $web_dir = '/usr/share/nagios3/htdocs/'
      $web_user = 'www'
      $web_group = 'www'
      $srv_package = 'nagios'
      $plugin_packages = [
        'nagios-plugins',
        'nagios-plugins-extras',
        'nagios-plugins-nrpe']
    }
    'centos' : {
      $nagios_cfg_dir = '/etc/nagios'
      $nagios_service = 'nagios'
      $srv_has_status = true
      $cgi_dir = '/usr/lib/cgi-bin/nagios3/'
      $cgi_path = '/cgi-bin/nagios3/'
      $web_dir = '/usr/share/nagios3/htdocs/'
      $web_user = 'www'
      $web_group = 'www'
      $srv_package = 'nagios'
      $plugin_packages = [
        'nagios-plugins',
        'nagios-plugins-smtp',
        'nagios-plugins-http',
        'nagios-plugins-ssh',
        'nagios-plugins-tcp',
        'nagios-plugins-dig',
        'nagios-plugins-nrpe',
        'nagios-plugins-load',
        'nagios-plugins-dns',
        'nagios-plugins-ping',
        'nagios-plugins-procs',
        'nagios-plugins-users',
        'nagios-plugins-ldap',
        'nagios-plugins-disk',
        'nagios-plugins-swap',
        'nagios-plugins-nagios',
        'nagios-plugins-perl',
        'nagios-plugins-ntp',
        'nagios-plugins-snmp']
    }
    default  : {
      fail("running nagios monitoring server not supported on  operating system ${::operatingsystem}"
      )
    }
  }

}
