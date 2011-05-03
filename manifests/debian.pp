class rsyslog::debian inherits rsyslog {

	include rsyslog

	package { 'rsyslog': ensure => present }

	Service[rsyslog-service] { 
		name => 'rsyslog',
		hasstatus => true, 
		subscribe => [ File[rsyslog-default], Package['rsyslog'] ],
	}

	File[rsyslog-conf] { require => Package['rsyslog'] }

	file { rsyslog-default:
		path => '/etc/default/rsyslog',
		content => "RSYSLOGD_OPTIONS=\"-c5\"\n",
		owner => 'root',
		group => 'root',
		mode => 0644,
	}

}
