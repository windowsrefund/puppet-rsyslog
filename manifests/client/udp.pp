class rsyslog::client::udp {

	include rsyslog::client 
	rsyslog::config { "log-udp": content => inline_template("*.*\t@<%= my_log_server %>\n") }

}

