class rsyslog::client::relp {

	if $my_loghost {

		rsyslog::client { relp: }

	} else {

		fail("The $my_loghost variable is not set.")

	}

}
