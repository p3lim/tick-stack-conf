# This class sets up the DNS server for the management network.
# https://github.com/ajjahn/puppet-dns#usage
# https://github.com/ajjahn/puppet-dns#exported-resource-patterns

class profile::dns::server {
	# Install the DNS server
	include dns::server

	# Set forwarding addresses (CloudFlare DNS)
	dns::server::options { '/etc/named/named.conf.options':
		forwarders => [
			'1.1.1.1',
			'1.0.0.1'
		],
	}

	# Set forward zone
	dns::zone { 'lab':
		soa         => $::fqdn,
		soa_email   => "admin.${::domain}",
		nameservers => [$::hostname],
	}

	# Collect A records from other nodes
	Dns::Record::A <<||>>

	# Open up the firewall for DNS traffic
	::profile::firewall::management { 'DNS TCP':
		port     => 53,
		protocol => 'tcp',
	}

	::profile::firewall::management { 'DNS UDP':
		port     => 53,
		protocol => 'udp',
	}
}
