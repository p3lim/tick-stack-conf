class profile::swarm::manager {
	include 'docker'

	docker::swarm { 'cluster':
		init           => true,
		advertise_addr => $::ipaddress,
		listen_addr    => $::ipaddress,
		before         => File['/etc/puppetlabs/facter/facts.d/swarm_token.sh'],
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

	# firewall
	::profile::firewall::management { 'Docker Swarm Manager TCP':
		port     => [2376, 2377, 7946],
		protocol => 'tcp',
	}

	::profile::firewall::management { 'Docker Swarm Manager UDP':
		port     => [7946, 4789],
		protocol => 'udp',
	}
}
