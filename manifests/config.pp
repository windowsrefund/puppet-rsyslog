define rsyslog::config($ensure = present, $content) {

	include rsyslog

	file { "config-$name": 
		path => "${rsyslog::conf_dir}/$name.conf",
		ensure => $ensure,
		content => "$content",
		notify => Service[rsyslog-service],
		owner => 'root',
		group => 'root', 
		mode => 0644,
	}
}
