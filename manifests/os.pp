class rsyslog::os inherits rsyslog {

	include rsyslog::params

	case $operatingsystem {

		debian: {

			Service[$rsyslog::params::service] { 
				hasstatus => true, 
				subscribe +> File[rsyslog-default],
			}

			file { rsyslog-default:
				path => '/etc/default/rsyslog',
				content => "RSYSLOGD_OPTIONS=\"-c5\"\n",
				owner => 'root',
				group => 'root',
				mode => 0644,
			}
			
		}

	}

}
