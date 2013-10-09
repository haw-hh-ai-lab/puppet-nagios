class nagios::apache(
  $allow_external_cmd = false,
  $manage_shorewall = false,
  $manage_munin = false,
  $auth_type = 'file',
  $auth_config = {},
) {
  class{'nagios':
    httpd => 'apache',
    allow_external_cmd => $allow_external_cmd,
    manage_munin => $manage_munin,
    manage_shorewall => $manage_shorewall,
  }

  include nagios::params

  apache::mod { 'cgi': }

  # no password entry without encryption
  apache::mod { 'ssl': }

  #
  # set up the parameter for the apache configuration template
  #
  $web_ip = $::ipaddress
  $server_admin = "monitoring@$::domain"
  $vhost_name = $::fqdn

  # TODO: this is ubuntu only
  $ssl_cert_file = "/etc/ssl/certs/ssl-cert-snakeoil.pem"
  $ssl_key_file = "/etc/ssl/private/ssl-cert-snakeoil.key"
  $ssl_ca_cert_file = "/etc/ssl/certs/ca-certificates.crt"

  case $auth_type {
    'file' : {
       $apache_conf = file([ "puppet:///site_nagios/configs/${::fqdn}/apache2.conf",
                               "puppet:///site_nagios/configs/apache2.conf",
                               "puppet:///nagios/configs/apache2.conf"])  
    }

    'ldap' : {

      # add the module
      apache::mod { 'authnz_ldap': }

      #
      # template takes the following arguments:
      #
      #   web_ip: ip address of the web server
      #   server_admin: email address of the admin for the nagios web server
      #   auth_ldap_require: string on what is required to authenticate the user
      #   auth_ldap_url: URL of the server to connect to
      #   auth_ldap_bind_dn: the DN to do the admin bind to
      #   auth_ldap_bind_pw: the password of the admin bind.
      #
      #   nagios::params::cgi_dir
      #   nagios::params::web_dir
      $auth_ldap_require = $auth_config[ldap_require]  
      $auth_ldap_url = $auth_config[ldap_url]
      $auth_ldap_bind_dn = $auth_config[ldap_bind_dn]
      $auth_ldap_bind_pw = $auth_config[ldap_bind_pw]
            
      $apache_conf = template('nagios/nagios/apache2_w_ldap.conf.erb')
      
    }
  }
 
  # additional details depending on the operating system 
  case $::operatingsystem {
    'debian': { }
    'SLES':   {
      
      package { 'nagios-www':
         ensure => present,
       }
      
     }
    'Ubuntu': {
	file { '/usr/share/nagios3/htdocs/stylesheets':
		ensure => link,
		target => '/etc/nagios3/stylesheets',
	}
	file { [ '/usr/share/nagios3/htdocs/stylesheets/avail.css',
		 '/usr/share/nagios3/htdocs/stylesheets/checksanity.css',
                 '/usr/share/nagios3/htdocs/stylesheets/cmd.css',
                 '/usr/share/nagios3/htdocs/stylesheets/common.css',
                 '/usr/share/nagios3/htdocs/stylesheets/config.css',
                 '/usr/share/nagios3/htdocs/stylesheets/extinfo.css',
                 '/usr/share/nagios3/htdocs/stylesheets/histogram.css',
                 '/usr/share/nagios3/htdocs/stylesheets/history.css',
                 '/usr/share/nagios3/htdocs/stylesheets/ministatus.css',
                 '/usr/share/nagios3/htdocs/stylesheets/notifications.css',
                 '/usr/share/nagios3/htdocs/stylesheets/outages.css',
                 '/usr/share/nagios3/htdocs/stylesheets/showlog.css',
                 '/usr/share/nagios3/htdocs/stylesheets/status.css',
                 '/usr/share/nagios3/htdocs/stylesheets/statusmap.css',
                 '/usr/share/nagios3/htdocs/stylesheets/summary.css',
                 '/usr/share/nagios3/htdocs/stylesheets/tac.css',
                 '/usr/share/nagios3/htdocs/stylesheets/trends.css',
		]:
		owner => 'root',
		group => 'root',
		mode => '644',
	}
     }

   }
  
  file { "${nagios::defaults::vars::int_cfgdir}/apache2.conf":
     ensure => present,
     content => $apache_conf,
     notify => Service['httpd'],
   }

  apache::config::global { "nagios3.conf":
     ensure => link,
     target => "${nagios::defaults::vars::int_cfgdir}/apache2.conf",
     require => File["${nagios::defaults::vars::int_cfgdir}/apache2.conf"],
   }
    
}
