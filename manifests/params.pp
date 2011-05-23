class rsyslog::params {
	
	$udp_listener = 'UDPServerRun' 
	$tcp_listener = 'InputTCPServerRun'
	$relp_listener = 'InputRELPServerRun'

	$udp_binder = 'InputUDPServerBindRuleset'
	$tcp_binder = 'InputTCPServerBindRuleset'
	$relp_binder = ''

	$udp_default_port = '514'
	$tcp_default_port = '10514'
	$relp_default_port = '20514'

	case $operatingsystem {

		debian: {
			$packages = [ 'rsyslog', 'rsyslog-relp' ]
			$service = 'rsyslog' 
			$conf_dir = '/etc/rsyslog.d'
			$conf = '/etc/rsyslog.conf'
			$work_dir = '/var/spool/rsyslog'
			$user = 'rsyslog'
			$group = 'rsyslog'
		}

		default: {

			fail("$operatingsystem is not supported.")

		}

	}

}
