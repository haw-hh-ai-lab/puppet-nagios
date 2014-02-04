#
# provide utility class for fully qualified names.
#

class nagios::target::fqdn(
  $hostgroups = 'absent',
  $parents = 'absent',
  $contact_groups = 'absent',
  $contacts = 'absent',
) {
  class{'nagios::target':
    address => $::fqdn,
    hostgroups => $hostgroups,
    parents => $parents,
    contact_groups = $contact_groups,
    contacts = $contacts
  }
}
