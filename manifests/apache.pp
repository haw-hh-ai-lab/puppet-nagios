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

  case $auth_type {
    'file' : {
       $apache_conf = file([ "puppet:///site_nagios/configs/${::fqdn}/apache2.conf",
                               "puppet:///site_nagios/configs/apache2.conf",
                               "puppet:///nagios/configs/apache2.conf"])  
    }

    'ldap' : {
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
      $auth_ldap_require = $auth_config['ldap_require']  
      $auth_ldap_url = $auth_config['ldap_url']
      $auth_ldap_bind_dn = $auth_config['ldap_bind_dn']
      $auth_ldap_bind_pw = $auth_config['ldap_bind_pw']
            
      $apache_conf = template("puppet:///nagios/nagios/apache2_w_ldap.conf.erb")
      
    }
  }
  
  case $::operatingsystem {
    'debian': {
      file { "${nagios::defaults::vars::int_cfgdir}/apache2.conf":
        ensure => present,
        content => $apache_conf,
      }

      apache::config::global { "nagios3.conf":
        ensure => link,
        target => "${nagios::defaults::vars::int_cfgdir}/apache2.conf",
        require => File["${nagios::defaults::vars::int_cfgdir}/apache2.conf"],
      }
    }
  }
}
