# This class joins workers into the Docker Swarm.

class profile::swarm::worker {
	# Install Docker first
	include 'docker'

	# Get facts about the swarm master
	$master = puppetdb_query('inventory[facts] {facts.trusted.certname ~ "master"}')

	# Join the swarm using the master's IP and swarm worker token
	docker::swarm { 'cluster':
		join           => true,
		advertise_addr => $::ipaddress,
		listen_addr    => $::ipaddress,
		manager_ip     => $master[0]['facts']['ipaddress'],
		token          => $master[0]['facts']['swarm_token'],
	}

	# Configure firewall to accept Docker Swarm TCP and UDP ports
	::profile::firewall::management { 'Docker Swarm Worker TCP':
		port     => [2376, 7946],
		protocol => 'tcp',
	}

	::profile::firewall::management { 'Docker Swarm Worker UDP':
		port     => [7946, 4789],
		protocol => 'udp',
	}
}
