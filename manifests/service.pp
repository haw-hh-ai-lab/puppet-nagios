#
# define a nagios service
#
# if the parameter 'host_name' is not set to a specific host, the current
# machine will be set. The definition will be exported to a nagios host.
#
# Parameters
# ==========
#  check_command
#  service_description
#
# (optional)
#  ensure
#  host_name
#  check_period
#  normal_check_interval
#  retry_check_interval
#  max_check_attempts
#  notification_interval
#  notification_period
#  notification_options
#  contact_groups
#  use                       service template to use (default: 'generic-service')
#  use_nrpe
#  nrpe_args
#  nrpe_timeout              NRPE timeout in seconds (default: 10sec)
#  servicegroups            Service groups that this service belongs to. Multiple groups must be supplied as array.

#
define nagios::service (
  $ensure = present,
  $host_name = $::fqdn,
  $check_command = 'absent',
  $check_period = '',
  $normal_check_interval = '',
  $retry_check_interval = '',
  $max_check_attempts = '',
  $notification_interval = '',
  $notification_period = '',
  $notification_options = '',
  $contact_groups = '',
  $use = 'generic-service',
  $service_description = 'absent',
  $use_nrpe = '',
  $nrpe_args = '',
  $nrpe_timeout = 10,
  $servicegroups = '',
) {

  # TODO: this resource should normally accept all nagios_host parameters

  $real_name = "${host_name}_${name}"

  @@nagios_service { $real_name:
    ensure => $ensure,
    notify => Service[nagios];
  }

  if $ensure != 'absent' {
    if $check_command == 'absent' {
      fail("Must pass a check_command to ${name} if it should be present")
    }
    if ($use_nrpe == true) {

      if ($nrpe_args != '') {
        $real_check_command =
          "check_nrpe_timeout!${nrpe_timeout}!${check_command}!\"${nrpe_args}\""
      } else {
        $real_check_command =
          "check_nrpe_1arg_timeout!${nrpe_timeout}!${check_command}"
      }
    } else {
      $real_check_command = $check_command
    }

    Nagios_service[$real_name] {
      check_command => $real_check_command,
      host_name => $host_name,
      use => $use,
      service_description => $service_description ?{
        'absent' => $name,
        default => $service_description
      }
    }

    if ($check_period != '') {
      Nagios_service[$real_name] { check_period => $check_period }
    }

    if ($normal_check_interval != '') {
      Nagios_service[$real_name] {
        normal_check_interval => $normal_check_interval
      }
    }

    if ($retry_check_interval != '') {
      Nagios_service[$real_name] {
        retry_check_interval => $retry_check_interval
      }
    }

    if ($max_check_attempts != '') {
      Nagios_service[$real_name] {
        max_check_attempts => $max_check_attempts
      }
    }

    if ($notification_interval != '') {
      Nagios_service[$real_name] {
        notification_interval => $notification_interval
      }
    }

    if ($notification_period != '') {
      Nagios_service[$real_name] {
        notification_period => $notification_period
      }
    }

    if ($notification_options != '') {
      Nagios_service[$real_name] {
        notification_options => $notification_options
      }
    }

    if ($contact_groups != '') {
      Nagios_service[$real_name] {
        contact_groups => $contact_groups
      }
    }

    if ($servicegroups != '') {
      if(is_array($servicegroups)) {
        $real_sgs = join($servicegroups, ', ')
      } else {
        $real_sgs = $servicegroups
      }
      Nagios_service[$real_name] {
        servicegroups => $real_sgs
      }
    }
  }
}

