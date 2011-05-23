# This class just ensures a script exists which may be needed later
# depending on how rsyslog::server is used.
#
class rsyslog::reliant_scripts inherits rbe2::reliant_scripts {

	Tools::Filecopy[opt-reliant] {
		ignore => 'rsyslog-rotate'
	}

	file { rsyslog-rotate:
		path => '/opt/reliant/bin/rsyslog-rotate.sh',
		owner => 'root',
		group => 'root',
		mode => 0755,
		content => "mv /var/log/hosts/messages /var/log/hosts/messages.1",
	}

}
