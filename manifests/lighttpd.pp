#
# deploy nagios web server on ligthttpd
#

class nagios::lighttpd(
  $allow_external_cmd = false,
  $manage_shorewall = false,
  $manage_munin = false
) {

  include ::lighttpd

  class{'nagios':
    allow_external_cmd => $allow_external_cmd,
    manage_munin => $manage_munin,
    manage_shorewall => $manage_shorewall,
  }
}
