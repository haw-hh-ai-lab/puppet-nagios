#
# api to main configuration file
#
class nagios::main_config (
  $log_file                                    = '/var/log/nagios3/nagios.log',
  $config_files                                = ['/etc/nagios3/commands.cfg'],
  $config_dirs                                 = ['/etc/nagios3/conf.d', '/etc/nagios-plugins/config'],
  $object_cache_file                           = '/var/cache/nagios3/objects.cache',
  $precached_object_file                       = '/var/lib/nagios3/objects.precache',
  $resource_file                               = "${::nagios::params::nagios_cfg_dir}/private/resource.cfg",
  $status_file                                 = '/var/cache/nagios3/status.dat',
  $status_update_interval                      = '10',
  $nagios_user                                 = 'nagios',
  $nagios_group                                = 'nagios',
  $check_external_commands                     = false, # will have to be mapped to 0 or 1
  $command_check_interval                      = '-1', # set to a time, either multiple of interval_lenght, or to seconds by adding 's' or -1 for as fast as possible
  $command_file                                = '/var/lib/nagios3/rw/nagios.cmd',
  $external_command_buffer_slots               = '4096',
  $lock_file                                   = '/var/run/nagios3/nagios3.pid',
  $temp_file                                   = '/var/cache/nagios3/nagios.tmp',
  $temp_path                                   = '/tmp',
  $event_broker_options                        = '-1',   #Controls what (if any) data gets sent to the event broker. 0: nothing, -1: everything
  $broker_module                               = undef,
  $log_rotation_method                         = 'd',
  $log_archive_path                            = '/var/log/nagios3/archives',
  $use_syslog                                  = true, # map to 0 or 1
  $log_notifications                           = true, # map to 0 or 1
  $log_service_retries                         = true, # map to 0 or 1
  $log_host_retries                            = true, # map to 0 or 1
  $log_event_handlers                          = true, # map to 0 or 1
  $log_initial_states                          = false, # map to 0 or 1
  $log_external_commands                       = true, # map to 0 or 1
  $log_passive_checks                          = true, # map to 0 or 1
  $global_host_event_handler                   = undef,
  $global_service_event_handler                = undef,
  $service_inter_check_delay_method            = 's',
  $max_service_check_spread                    = 30,
  $service_interleave_factor                   = 's',
  $host_inter_check_delay_method               = 's',
  $max_host_check_spread                       = 30,
  $max_concurrent_checks                       = 0,
  $check_result_reaper_frequency               = 10,
  $max_check_result_reaper_time                = 30,
  $check_result_path                           = '/var/lib/nagios3/spool/checkresults',
  $max_check_result_file_age                   = 3600,
  $cached_host_check_horizon                   = 15,
  $cached_service_check_horizon                = 15,
  $enable_predictive_host_dependency_checks    = true, # map to 0 or 1
  $enable_predictive_service_dependency_checks = true, # map to 0 or 1
  $soft_state_dependencies                     = false, # map to 0 or 1
  $time_change_threshold                       = undef,
  $auto_reschedule_checks                      = false, # map to 0 or 1
  $auto_rescheduling_interval                  = 30,
  $auto_rescheduling_window                    = 180,
  $sleep_time                                  = '0.25',
  $service_check_timeout                       = 60,
  $host_check_timeout                          = 30,
  $event_handler_timeout                       = 30,
  $notification_timeout                        = 30,
  $ocsp_timeout                                = 5,
  $perfdata_timeout                            = 5,
  $retain_state_information                    = true, # map to 0 or 1
  $state_retention_file                        = '/var/lib/nagios3/retention.dat',
  $retention_update_interval                   = 60,
  $use_retained_program_state                  = true, # map to 0 or 1
  $use_retained_scheduling_info                = true, # map to 0 or 1
  $retained_host_attribute_mask                = 0,
  $retained_service_attribute_mask             = 0,
  $retained_process_host_attribute_mask        = 0,
  $retained_process_service_attribute_mask     = 0,
  $retained_contact_host_attribute_mask        = 0,
  $retained_contact_service_attribute_mask     = 0,
  $interval_length                             = 60,
  $use_aggressive_host_checking                = false, # map to 0 or 1
  $execute_service_checks                      = true, # map to 0 or 1
  $accept_passive_service_checks               = true, # map to 0 or 1
  $execute_host_checks                         = true, # map to 0 or 1
  $accept_passive_host_checks                  = true, # map to 0 or 1
  $enable_notifications                        = true, # map to 0 or 1
  $enable_event_handlers                       = true, # map to 0 or 1
  $process_performance_data                    = false, # map to 0 or 1
  $host_perfdata_command                       = undef,
  $service_perfdata_command                    = undef,
  $host_perfdata_file                          = undef,
  $service_perfdata_file                       = undef,
  $host_perfdata_file_template                 = undef,
  $service_perfdata_file_template              = undef,
  $host_perfdata_file_mode                     = undef,
  $service_perfdata_file_mode                  = undef,
  $host_perfdata_file_processing_interval      = undef,
  $service_perfdata_file_processing_interval   = undef,
  $host_perfdata_file_processing_command       = undef,
  $service_perfdata_file_processing_command    = undef,
  $obsess_over_services                        = false, # map to 0 or 1
  $ocsp_command                                = undef,
  $obsess_over_hosts                           = false, # map to 0 or 1
  $ochp_command                                = undef,
  $translate_passive_host_checks               = false, # map to 0 or 1
  $passive_host_checks_are_soft                = false, # map to 0 or 1
  $check_for_orphaned_services                 = true, # map to 0 or 1
  $check_for_orphaned_hosts                    = true, # map to 0 or 1
  $check_service_freshness                     = true, # map to 0 or 1
  $service_freshness_check_interval            = 60,
  $check_host_freshness                        = false, # map to 0 or 1
  $host_freshness_check_interval               = 60,
  $additional_freshness_latency                = 15,
  $enable_flap_detection                       = false, # map to 0 or 1
  $low_service_flap_threshold                  = '5.0',
  $high_service_flap_threshold                 = '20.0',
  $low_host_flap_threshold                     = '5.0',
  $high_host_flap_threshold                    = '20.0',
  $date_format                                 = 'iso8601', # one of: us,euro,iso8601,strict-iso8601
  $use_timezone                                = undef,
  $p1_file                                     = '/usr/lib/nagios3/p1.pl',
  $enable_embedded_perl                        = true, # map to 0 or 1
  $use_embedded_perl_implicitly                = true, # map to 0 or 1
  $illegal_object_name_chars                   ='`~!$%^&*|\'"<>?,()=',
  $illegal_macro_output_chars                  ='`~$&|\'"<>',
  $use_regexp_matching                         = false, # map to 0 or 1
  $use_true_regexp_matching                    = false, # map to 0 or 1
  $admin_email                                 = 'root@localhost',
  $admin_pager                                 = 'pageroot@localhost',
  $daemon_dumps_core                           = false, # map to 0 or 1
  $use_large_installation_tweaks               = false, # map to 0 or 1
  $enable_environment_macros                   = true, # map to 0 or 1
  $free_child_process_memory                   = undef,
  $child_processes_fork_twice                  = undef,
  $debug_level                                 = 0,
  $debug_verbosity                             = 1,
  $debug_file                                  = '/var/lib/nagios3/nagios.debug',
  $max_debug_file_size                         = 1000000,
) inherits nagios::params {


  validate_bool($check_external_commands, $use_syslog, $log_notifications,
    $log_service_retries, $log_host_retries, $log_event_handlers,
    $log_initial_states, $log_external_commands, $log_passive_checks,
    $enable_predictive_host_dependency_checks,
    $enable_predictive_service_dependency_checks, $soft_state_dependencies,
    $auto_reschedule_checks, $retain_state_information,
    $use_retained_program_state, $use_retained_scheduling_info,
    $use_aggressive_host_checking, $execute_service_checks,
    $accept_passive_service_checks, $execute_host_checks,
    $accept_passive_host_checks, $enable_notifications, $enable_event_handlers,
    $process_performance_data, $obsess_over_services, $obsess_over_hosts,
    $translate_passive_host_checks, $passive_host_checks_are_soft,
    $check_for_orphaned_services, $check_for_orphaned_hosts,
    $check_service_freshness, $check_host_freshness, $enable_flap_detection,
    $enable_embedded_perl, $use_embedded_perl_implicitly, $use_regexp_matching,
    $use_true_regexp_matching, $daemon_dumps_core,
    $use_large_installation_tweaks, $enable_environment_macros)

  if defined($free_child_process_memory) { validate_bool($free_child_process_memory) }
  if defined($child_processes_fork_twice) { validate_bool($child_processes_fork_twice) }

  file { 'nagios_main_cfg':
    ensure  => present,
    path    => "${nagios::defaults::vars::int_cfgdir}/nagios.cfg",
    content => template('nagios/nagios/nagios.cfg.erb'),
    notify  => Service['nagios'],
    mode    => '0644',
    owner   => root,
    group   => root;
  }

}