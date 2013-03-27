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
   
   
}