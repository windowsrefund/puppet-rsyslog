class rsyslog {

	$conf_dir = '/etc/rsyslog.d'
	$conf = '/etc/rsyslog.conf'
	$rsyslog_user = 'rsyslog'
	$rsyslog_group = 'rsyslog'

	# Each supported client OS goes here
	case $operatingsystem {
		debian: { include rsyslog::debian }	
	}

	group { "$rsyslog_group": ensure => present }

	user { "$rsyslog_user": 
		ensure => present,
		gid => $rsyslog_group,
		require => Group[$rsyslog_group],
	}

	file { 
		rsyslog-conf:
			path => $conf,
			ensure => present,
			owner => 'root',
			group => 'root',
			mode => 0644,
			content => template('rsyslog/global/rsyslog.conf.erb'),
			require => User[$rsyslog_user], 
			notify => Service[rsyslog-service];
		rsyslog-d:
			path => $conf_dir,
			ensure => directory,
			owner => 'root',
			group => 'root',
			mode => 0755;
	}

	service { rsyslog-service:
		enable => true,
		ensure => running,
	}

}
