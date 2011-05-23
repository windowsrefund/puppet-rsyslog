# This definition will add a iptables rule for rsyslog depending on
# how the server is configured to run.
define rsyslog::iptables($proto, $dport) {

	include iptables 

	iptables { "$name":
		proto => $proto,
		dport => $dport,
		jump => 'ACCEPT';
	} 

}
