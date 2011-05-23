# This is a simple wrapper class that is meant to be deployed to level
# 3 of a 3-tier logging framework.
class rsyslog::top {

	rsyslog::server { 'top': 
		proto => 'relp', 
		templ => [ 'hostsbydirectory', 'standardwithpri' ],
	}

}
