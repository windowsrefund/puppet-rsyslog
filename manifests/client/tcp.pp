class rsyslog::client::tcp {

	include rsyslog::client 
	rsyslog::config { "log-tcp": content => inline_template("*.*\t@@<%= my_log_server %>\n") }

}
