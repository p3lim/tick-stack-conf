# This class initiates a Docker Swarm cluster.

class profile::swarm::manager {
	# Install Docker first
	include 'docker'

	# Create the swarm
	docker::swarm { 'cluster':
		init           => true,
		advertise_addr => $::ipaddress,
		listen_addr    => $::ipaddress,
		before         => File['/etc/puppetlabs/facter/facts.d/swarm_token.sh'],
	}

	# Create the parent directory for Facter facts
	file { ['/etc/puppetlabs/facter', '/etc/puppetlabs/facter/facts.d']:
		ensure => 'directory',
		owner  => 'root',
		group  => 'root',
	}

	# Define script that will act as a custom Facter fact, containing the
	# worker token for the swarm
	$fact_content = '#!/bin/bash
echo "swarm_token=$(docker swarm join-token worker -q)"
'

	# Create script
	file { '/etc/puppetlabs/facter/facts.d/swarm_token.sh':
		owner   => 'root',
		group   => 'root',
		content => $fact_content,
		mode    => '0755',
		require => File['/etc/puppetlabs/facter/facts.d'],
	}

	# Configure firewall to accept Docker Swarm TCP and UDP ports
	::profile::firewall::management { 'Docker Swarm Manager TCP':
		port     => [2376, 2377, 7946],
		protocol => 'tcp',
	}

	::profile::firewall::management { 'Docker Swarm Manager UDP':
		port     => [7946, 4789],
		protocol => 'udp',
	}
}
