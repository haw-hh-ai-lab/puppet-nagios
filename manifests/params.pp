

class nagios::params {

	case $::operatingsystem {
		'Ubuntu' : {
			$cgi_dir = "/usr/lib/cgi-bin/nagios3/"
			$web_dir = "/usr/share/nagios3/htdocs/"
  		}
		default: {
			fail("running nagios monitoring server not supported on  operating system $::operatingsystem")
		}
	}

} 
