Puppet rsyslog module
=====================

Provides management of rsyslogd client and server

Supported Platforms
-------------------

- Debian GNU/Linux

Supported Features
-------------------
- UDP, TCP, and RELP protocols (server and client)
- Port assignment
- Rule framework (see rsyslog::rule::remotehost)

Examples
--------
Create a udp server:

    rsyslog::server { 'udp': }

Create a udp client:

    $my_loghost = '192.168.0.1'
    include rsyslog::client::udp

Create a tcp server on port 583 (non-standard) and ensure no udp configuration exists:

    rsyslog::server { 
        'tcp': port => '583';
        'udp': ensure => absent;
    }

Create a tcp client:

    $my_loghost = '192.168.0.1'
    include rsyslog::client::tcp

Credits
-------
This module was inspired by tdfisher's rsyslog module
http://gitorious.org/puppet-rsyslog/
