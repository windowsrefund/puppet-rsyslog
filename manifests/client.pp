# = Class: rsyslog::client
#
# Do not use this class directly. Instead, use one of the following:
#
# - rsyslog::client::udp
# - rsyslog::client::tcp
class rsyslog::client inherits rsyslog {

	rsyslog::module { [ "imuxsock", "imklog" ]: }

}
