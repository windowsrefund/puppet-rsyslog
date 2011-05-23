class rsyslog::client::tcp {

	if $my_loghost {

		rsyslog::client { tcp: }

	} else {

		fail("The $my_loghost variable is not set.")

	}

}
