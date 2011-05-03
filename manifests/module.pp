define rsyslog::module($content = undef, $ensure = present) {

	rsyslog::config { "module-$name": 
		ensure => $ensure,
		content => "\$ModLoad $name\n$content", 
	}

}
