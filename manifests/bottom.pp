# This is a simple wrapper class that is meant to be deployed to level
# 1 of a 3-tier logging framework.
class rsyslog::bottom {
	include rsyslog::client::relp
}
