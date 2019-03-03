class profile::swarm::worker {
	include 'docker'

	$master = puppetdb_query('inventory[facts] {facts.trusted.certname ~ "master"}')

	docker::swarm { 'cluster':
		join           => true,
		advertise_addr => $::ipaddress,
		listen_addr    => $::ipaddress,
		manager_ip     => $master[0]['facts']['ipaddress'],
		token          => $master[0]['facts']['swarm_token'],
	}

	# firewall
	::profile::firewall::management { 'Docker Swarm Worker TCP':
		port     => [2376, 7946],
		protocol => 'tcp',
	}

	::profile::firewall::management { 'Docker Swarm Worker UDP':
		port     => [7946, 4789],
		protocol => 'udp',
	}
}
