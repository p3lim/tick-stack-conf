# https://github.com/ajjahn/puppet-dns#exported-resource-patterns

# this class notifies the DNS server that the client is available at the given IP address
class profile::dns::client {
	# export A record for the node's hostname
	@@dns::record::a { $::hostname:
		zone => 'lab',
		data => $::ipaddress,
	}
}
