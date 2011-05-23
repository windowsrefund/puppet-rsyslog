class rsyslog {

	include rsyslog::params 	
	include rsyslog::os

	package { $rsyslog::params::packages: ensure => present }

	group { $rsyslog::params::group: ensure => present }

	user { $rsyslog::params::user: 
		ensure => present,
		gid => $rsyslog::params::group,
		require => Group[$rsyslog::params::group],
	}

	File {
		owner => 'root',
		group => 'root',
	}

	file { 
		$rsyslog::params::conf:
			ensure => present,
			mode => 0644,
			content => template('rsyslog/global/rsyslog.conf.erb'),
			subscribe => Package[$rsyslog::params::packages];
		$rsyslog::params::conf_dir:
			ensure => directory,
			mode => 0755;
		$rsyslog::params::work_dir:
			ensure => directory,
			mode => 0755,
			owner => $rsyslog::params::user,
			require => User[$rsyslog::params::user]; 
		outchannels:
			path => "${rsyslog::params::conf_dir}/outchannels.conf",
			ensure => present,
			source => 'puppet:///modules/rsyslog/global/outchannels.conf';
		templates:
			path => "${rsyslog::params::conf_dir}/templates.conf",
			ensure => present,
			source => 'puppet:///modules/rsyslog/global/templates.conf';
	}

	service { $rsyslog::params::service:
		enable => true,
		ensure => running,
		subscribe => File[$rsyslog::params::conf],
	}

}
