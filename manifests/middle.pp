# This is a simple wrapper class that is meant to be deployed to level
# 2 of a 3-tier logging framework.
class rsyslog::middle {

	rsyslog::server { 'middle-udp': 
		proto => 'udp', 
		outchannel => 'rotate50mb',
	}
	rsyslog::server { 'middle-tcp': 
		proto => 'tcp', 
		outchannel => 'rotate50mb',
	}
	rsyslog::server { 'middle-relp': 
		proto => 'relp', 
		outchannel => 'rotate50mb',
	}

	include rsyslog::client::relp

}
