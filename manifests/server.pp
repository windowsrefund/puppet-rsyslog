# This definition creates a udp, tcp, or relp enabled rsyslogd server
# and corresponding iptables rule.
#
# == Parameters
#
# * ensure (defaults to present)
# * port (see rsyslog::params for defaults)
# * protocol (defaults to udp) 
# * iptables (defaults to true)
# * filter (defaults to *.*)
# * outchannel (should exist in filles/global/outchannels.conf)
# * templ (defaults to an array with a single value of
# 'standardwithpri')
#
#  An array of template names. Each template should exist in
#  the files/global/templates.conf file. When using an outchannel, a
#  single template can be specified in order to create a rsyslog
#  action formatted as: $outchannel;template
#
#  One use case for specifying 2 templates would be where one template
#  is used to store the logs in a dynamic directory structure and the
#  other template is used to format the log's contents. When passing 2
#  template names into this parameter, the rsyslog action is formatted
#  as: ?template1;template2
#
# == Examples
#
# Create a server with default values (udp:514)
#
# rsyslog::server { 'foo': }
#
# Create a tcp listener on port 583 and ensure 
# a previously configured server has been removed
#
#	rsyslog::server { 
#		'my_tcp_logger': 
#			proto => 'tcp',
#			port => '583'; 
#		'my_legacy_logger': ensure => absent;
#	}
#
# It should also be possible to run multiple instances of
# the same protocol (on different ports obviously)
#
#	rsyslog::server {
#		'my_awesome_logger':
#			proto => 'tcp';
#		'my_more_awesome_logger':		
#			proto => 'tcp',
#			port => '515';
#	}
#
define rsyslog::server(
$port = '', 
$proto = 'udp', 
$filter = '*.*',
$ensure = present, 
$iptables = true,
$outchannel = '',
$templ = [ 'standardwithpri' ]
) {

	include rsyslog
	include rsyslog::reliant_scripts

	# This will be used by our template
	$binder = $proto ? {
		udp => $rsyslog::params::udp_binder,
		tcp => $rsyslog::params::tcp_binder,
		relp => $rsyslog::params::relp_binder,
	}

	# This will be used by our template
	$listener = $proto ? {
		udp => $rsyslog::params::udp_listener,
		tcp => $rsyslog::params::tcp_listener,
		relp => $rsyslog::params::relp_listener,
	}

	# This will be used by our template
	# Use the specified or default port for each supported protocol
	$listener_port = $proto ? {
		udp => inline_template("<%= port == '' ?  $rsyslog::params::udp_default_port : port %>"),
		tcp => inline_template("<%= port == '' ?  $rsyslog::params::tcp_default_port : port %>"),
		relp => inline_template("<%= port == '' ?  $rsyslog::params::relp_default_port : port %>"),
	}
	
	case $proto {
		udp,tcp,relp: { 

			file { "listener-${proto}-${listener_port}": 
				path => "${rsyslog::params::conf_dir}/listener-${proto}-${listener_port}.conf",
				ensure => $ensure,
				content => template('rsyslog/global/listener.erb'),
				notify => Service[$rsyslog::params::service],
				owner => 'root',
				group => 'root', 
				mode => 0644,
				require => Class['rsyslog::reliant_scripts'],
			}

			if ($iptables) and ($ensure == present) {

				# Add a firewall rule if the rsyslog server is enabled
				# This can be bypassed with iptables => false

				# The protocol will be tcp if rsyslog is set to use
				# RELP
				rsyslog::iptables { "${proto}-${listener_port}":
					proto => $proto ? {
						relp => 'tcp',
						default => $proto,
					},
					dport => $listener_port,
				}

			}

		}

		default: {

			fail("$proto is not supported.")

		}
	}

}
