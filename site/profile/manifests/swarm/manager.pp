class profile::swarm::manager {
	include 'docker'

	docker::swarm { 'cluster':
		init           => true,
		advertise_addr => $::ipaddress,
		listen_addr    => $::ipaddress,
	}

	file { ['/etc/puppetlabs/facter', '/etc/puppetlabs/facter/facts.d']:
		ensure => 'directory',
		owner  => 'root',
		group  => 'root',
	}

	$fact_content = '#!/bin/bash
echo "swarm_token=$(docker swarm join-token worker -q)"
'

	file { '/etc/puppetlabs/facter/facts.d/swarm_token.sh':
		owner   => 'root',
		group   => 'root',
		content => $fact_content,
		mode    => '0755',
		require => File['/etc/puppetlabs/facter/facts.d'],
	}

	# TODO: firewall (2376/tcp, 2377/tcp, 7946/tcp/udp, 4789/udp)
}

# swarm manager:
#   iptables -I INPUT -p tcp --dport 2376 -j ACCEPT
#   iptables -I INPUT -p tcp --dport 2377 -j ACCEPT
#   iptables -I INPUT -p tcp --dport 7946 -j ACCEPT
#   iptables -I INPUT -p udp --dport 7946 -j ACCEPT
#   iptables -I INPUT -p udp --dport 4789 -j ACCEPT
