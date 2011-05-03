class rsyslog::rule::remotehost{

	rsyslog::config { 'rule-remotehost':
		content => "\$template RemoteHost, \"/var/log/hosts/%HOSTNAME%/%\$YEAR%/%\$MONTH%/%\$DAY%/%syslogfacility-text%.log\"\nif \$source != 'localhost' then ?RemoteHost\n" 
	}

}
