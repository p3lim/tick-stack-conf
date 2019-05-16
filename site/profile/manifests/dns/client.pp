# This class notifies the DNS server that the client is available at the given IP address.
# https://github.com/ajjahn/puppet-dns#exported-resource-patterns

class profile::dns::client {
	# Export A record for the node's hostname in the private zone
	@@dns::record::a { $::hostname:
		zone => 'lab',
		data => $::ipaddress,
	}
}
