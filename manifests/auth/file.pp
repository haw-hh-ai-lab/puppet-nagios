#
# use file based username/pw for nagios access control
#
class nagios::auth::file(
  $config = [],
 ) {
 
    file { 'nagios_htpasswd':
        path => "${nagios::defaults::vars::int_cfgdir}/htpasswd.users",
        source => [ "puppet:///modules/site_nagios/htpasswd.users",
                    "puppet:///modules/nagios/htpasswd.users" ],
        mode => 0640, owner => root, group => $::apache::params::group;
    }


}