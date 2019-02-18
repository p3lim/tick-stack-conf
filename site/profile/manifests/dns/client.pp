# https://github.com/ajjahn/puppet-dns#exported-resource-patterns

class profile::dns::client {
	# export A record for the node's hostname
	@@dns::record::a { $::hostname:
		zone => 'lab',
		data => $::ipaddress,
	}
}
