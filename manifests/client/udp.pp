class rsyslog::client::udp {

	if $my_loghost {

		rsyslog::client { udp: }

	} else {

		fail("The $my_loghost variable is not set.")

	}

}
