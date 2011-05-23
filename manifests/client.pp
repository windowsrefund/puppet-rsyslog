# Rather than use this definition directly, the following classes
# provide cookie-cutter instances:
#
# - rsyslog::client::udp
# - rsyslog::client::tcp
# - rsyslog::client::relp
define rsyslog::client($port = '', $filter = '*.*') {

	include rsyslog

	# This will be used by our template
	# Use the specified or default port for each supported protocol
	$destination_port = $name ? {
		udp => inline_template("<%= port == '' ?  $rsyslog::params::udp_default_port : port %>"),
		tcp => inline_template("<%= port == '' ?  $rsyslog::params::tcp_default_port : port %>"),
		relp => inline_template("<%= port == '' ?  $rsyslog::params::relp_default_port : port %>"),
	}

	$destination = $name ? {
		udp => "@${my_loghost}",
		tcp => "@@${my_loghost}",
		relp => ":omrelp:${my_loghost}",
	}
	
	case $name {

		udp,tcp,relp: { 

			file { "sender-${name}-${destination_port}": 
				path => "${rsyslog::params::conf_dir}/sender-${name}-${destination_port}.conf",
				ensure => $ensure,
				content => inline_template("\$ModLoad om${name}\n${filter} ${destination}:${destination_port}\n"),
				notify => Service[$rsyslog::params::service],
				owner => 'root',
				group => 'root', 
				mode => 0644,
			}

		}

		default: {

			fail("$name is not supported.")

		}

	}


}
