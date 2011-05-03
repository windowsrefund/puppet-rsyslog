# = Definition: rsyslog::server
#
# == Examples
#
# Create a udp listener with default rule:
# rsyslog::server { 'udp': }
#
# Create a tcp listener on port 583 and ensure udp is disabled:
# rsyslog::server { 
#	'tcp': port => '583'; 
#   'udp': ensure => absent;
# }
define rsyslog::server($port = undef, $rule = 'remotehost', $ensure = present) {

	include rsyslog

	case $rule {
		remotehost: { include rsyslog::rule::remotehost }
		default: { fail("Unsupported rule: $rule") }
	}

	case $name {
		udp: { 
			rsyslog::module { "imudp": 
				ensure => $ensure,
				content => $port ? {
					'' => "\$UDPServerRun 514\n", 
					default => "\$UDPServerRun $port\n",
				}, 
			} 
		}
		tcp: { 
			rsyslog::module { "imtcp": 
				ensure => $ensure,
				content => $port ? {
					'' => "\$InputTCPServerRun 5140\n", 
					default => "\$InputTCPServerRun $port\n",
				}
			}
		}
		relp: { 
			rsyslog::module { "imrelp": 
				ensure => $ensure,
				content => $port ? {
					'' => "\$InputTCPServerRun 20514\n", 
					default => "\$InputRELPServerRun $port\n",
				},
			}
		}
		default: {
			fail("$name is not supported.")
		}
	}

}
