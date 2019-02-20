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
		soa         => $::fqdn,
		soa_email   => "admin.${::domain}",
		nameservers => [$::hostname],
	}

	# collect A records from other nodes
	Dns::Record::A <<||>>

	# TODO: firewall
}

# dns:
#   iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 53 -j ACCEPT
#   iptables -I INPUT -p udp -m state --state NEW -m udp --dport 53 -j ACCEPT
