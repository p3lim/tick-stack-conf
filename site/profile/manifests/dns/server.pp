# https://github.com/ajjahn/puppet-dns#usage
# https://github.com/ajjahn/puppet-dns#exported-resource-patterns

class profile::dns::server {
	include dns::server

	# forwarders
	dns::server::options { '/etc/named/named.conf.options':
		forwarders => [
			'1.1.1.1',
			'1.0.0.1'
		],
	}

	# forward zone
	dns::zone { 'lab':
		soa         => 'manager.tick.lab',
		soa_email   => 'admin.tick.lab',
		nameservers => ['manager'],
	}

	# collect A records from other nodes
	Dns::Record::A <<||>>
}
