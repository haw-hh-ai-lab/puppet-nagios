#
# calls nagios::apache: use apache httpd as web server
#
class nagios::apache (
  $allow_external_cmd = false,
  $manage_shorewall   = false,
  $manage_munin       = false,
  $auth_type          = 'file',
  $auth_config        = {
  }
  ,) {
  class { 'nagios':
    httpd              => 'apache',
    allow_external_cmd => $allow_external_cmd,
    manage_munin       => $manage_munin,
    manage_shorewall   => $manage_shorewall,
  }

  include nagios::params

  apache::mod { 'cgi':
  }

  # no password entry without encryption
  apache::mod { 'ssl':
  }

  #
  # set up the parameter for the apache configuration template
  #
  $web_ip = $::ipaddress
  $server_admin = "monitoring@${::domain}"
  $vhost_name = $::fqdn

  # TODO: this is ubuntu only
  $ssl_cert_file = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  $ssl_key_file = '/etc/ssl/private/ssl-cert-snakeoil.key'
  $ssl_ca_cert_file = '/etc/ssl/certs/ca-certificates.crt'

  case $auth_type {
    'file' : {
      file { "${nagios::defaults::vars::int_cfgdir}/apache2.conf":
        ensure => present,
        source => 'puppet:///nagios/configs/apache2.conf',

        # TODO: get service name from apache module
        notify => Service['httpd'],
      }

    }

    'ldap' : {
      # add the module
      # TODO: this dependency should be handled by the apache puppet module itself
      apache::mod { 'ldap': }
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

      case $apache::version::default {
        '2.2': {
          file { "${nagios::defaults::vars::int_cfgdir}/apache2.conf":
            ensure  => present,
            content => template('nagios/nagios/apache2_w_ldap.conf.erb'),
            notify  => Service['httpd'],
          }
        }
        '2.4': {
          file { "${nagios::defaults::vars::int_cfgdir}/apache2.conf":
            ensure  => present,
            content => template('nagios/nagios/apache2_w_ldap_v2.4.conf.erb'),
            notify  => Service['httpd'],
          }
        }
        default: { fail("Apache version ${apache::version::default} not supported") }
      }

    }
  }  # case $auth_type

  # additional details depending on the operating system
  case $::operatingsystem {
    'debian' : {
    }
    'SLES'   : {
      package { 'nagios-www':
        ensure => present,
      }

    }
    'Ubuntu' : {
      file { '/usr/share/nagios3/htdocs/stylesheets':
        ensure => link,
        target => '/etc/nagios3/stylesheets',
      }

      file { [
        '/usr/share/nagios3/htdocs/stylesheets/avail.css',
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
        mode  => '644',
      }
    }

  }

  # FIXME: this breaks encapsulation by the apache module. Move me and get me
  # accepted by the apache team.
  # see branch config_file_helper in haw-hh-ai-lab/puppetlabs-apache

  $apache_config_filename = 'nagios3.conf'

  file { "apache_${apache_config_filename}":
    ensure  => link,
    path    => "${::apache::params::confd_dir}/${name}",
    target  => "${nagios::defaults::vars::int_cfgdir}/apache2.conf",
    notify  => Service[$::apache::params::service_name],
    owner   => $::apache::params::user,
    group   => $::apache::params::group,
    mode    => 0644,
    require => [
      Package[$::apache::params::service_name],
      File["${nagios::defaults::vars::int_cfgdir}/apache2.conf"]]
  }

}
