#
# manifests/target.pp
#
class nagios::target(
  $parents = 'absent',
  $address = $::ipaddress,
  $nagios_alias = $::hostname,
  $hostgroups = 'absent',
  $contact_groups = 'absent',
  $contacts = 'absent',
  $host_template = 'generic-host',
){
  @@nagios_host { $::fqdn:
    address => $address,
    alias   => $nagios_alias,
    use     => $host_template,
  }

  if ($parents != 'absent') {
    Nagios_host[$::fqdn] { parents => $parents }
  }

  if ($hostgroups != 'absent') {
    Nagios_host[$::fqdn] { hostgroups => $hostgroups }
  }

  if ($contact_groups != 'absent') {
    Nagios_host[$::fqdn] { contact_groups => $contact_groups }
  }

  if ($contacts != 'absent') {
    Nagios_host[$::fqdn] { contacts => $contacts }
  }


}
