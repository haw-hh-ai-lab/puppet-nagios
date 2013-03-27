#
# uses hiera or config hash to set needed config values
#
# will require mod_ssl, mod_ldap_authn_authz(?)
#
# will require params:
#
#  ldap_host
#  ldap_bind_dn
#  ldap_bind_pw
#  ldap_require (array!)
#  ldap_group_attr (not used if undef)
#  ldap_group_attr_is_dn
#  nagios_base_path
#  nagios_install_dir
#
#
class nagios::auth::ldap (
  $config = undef,
 ) {
 
   if $config {
    create_resources(sshd_config, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('nagios::auth', undef)
    if $hiera_config {
      create_resources(sshd_config, $hiera_config, $defaults)
    }
  } else {
    fail("cannot create ldap authentication without config")
  }
   
   # Eintrag fuer apache2/conf.d/nagios.conf
#   <VirtualHost 141.22.31.56:80>
#  ServerAdmin nagios-admin@informatik.haw-hamburg.de
#  DocumentRoot /usr/share/nagios
#  ServerName nagios.informatik.haw-hamburg.de
#
#  Redirect seeother / https://nagios.informatik.haw-hamburg.de
#
#</VirtualHost>
#
#<VirtualHost 141.22.31.56:443>
#  ServerAdmin nagios-admin@informatik.haw-hamburg.de
#  DocumentRoot /usr/share/nagios
#  ServerName nagios.informatik.haw-hamburg.de
#
#  ScriptAlias /nagios/cgi-bin/ /usr/lib/nagios/cgi/
#  Alias  /  /usr/share/nagios/
#
#  SSLEngine on
#  SSLCertificateFile /etc/apache2/ssl.crt/nagios.informatik.haw-hamburg.de.crt
#  SSLCertificateKeyFile /etc/apache2/ssl.key/nagios.informatik.haw-hamburg.de-clear-key.pem
#  SSLCACertificateFile /etc/x509/informatik-ca.crt
#
#  ErrorLog /var/log/apache2/nagios-error_log
#  CustomLog /var/log/apache2/nagios-access_log combined
#
#  <Directory /usr/lib/nagios/cgi/>
#     Options ExecCGI
#     SSLRequireSSL
#
#     Order deny,allow
#     Allow from all
#     Deny from none
#
#     AuthType Basic
#     AuthName "Nagios"
#     AuthBasicProvider ldap
#
#     AuthLDAPURL ldap://dir-read.informatik.haw-hamburg.de/ou=Users,ou=dep-inf,o=haw-hamburg?uid??(objectClass=posixAccount) TLS
#     AuthLDAPBindDN cn=proxusr,ou=Admin,ou=dep-inf,o=haw-hamburg
#     AuthLDAPBindPassword {CRYPT}3pS4AmQs7Wm5U
#
#     AuthzLDAPAuthoritative on
#     AuthLDAPGroupAttribute memberUid
#     AuthLDAPGroupAttributeIsDN off
#
#     require ldap-group cn=sw_staff,ou=Groups,ou=dep-inf,o=haw-hamburg
#     require valid-user
#
#  </Directory>
#
#  <Directory /usr/share/nagios/>
#     Options None
#     SSLRequireSSL
#
#     Order deny,allow
#     Allow from all
#      Deny from none
#
#     AuthType Basic
#     AuthName "Nagios"
#     AuthBasicProvider ldap
#
#     AuthLDAPURL ldap://dir-read.informatik.haw-hamburg.de/ou=Users,ou=dep-inf,o=haw-hamburg?uid??(objectClass=posixAccount) TLS
#     AuthLDAPBindDN cn=proxusr,ou=Admin,ou=dep-inf,o=haw-hamburg
#     AuthLDAPBindPassword {CRYPT}3pS4AmQs7Wm5U
#
#     AuthzLDAPAuthoritative on
#     AuthLDAPGroupAttribute memberUid
#     AuthLDAPGroupAttributeIsDN off
#
#     require ldap-group cn=sw_staff,ou=Groups,ou=dep-inf,o=haw-hamburg
##     require valid-user
#
#  </Directory>
#
#  <Directory /usr/share/nagios/images/logos>
#     Options SymLinksIfOwnerMatch
#     SSLRequireSSL
#     allow from all
#     order allow,deny
#  </Directory>
#
#</VirtualHost>
   
   
}