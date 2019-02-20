class profile::swarm::worker {
	include 'docker'

	$manager = puppetdb_query('inventory[facts] {facts.trusted.certname ~ "manager"}')

	docker::swarm { 'cluster':
		join           => true,
		advertise_addr => $::ipaddress,
		listen_addr    => $::ipaddress,
		manager_ip     => $manager[0]['facts']['ipaddress'],
		token          => $manager[0]['facts']['swarm_token'],
	}

	# TODO: firewall (2376/tcp, 7946/tcp/udp, 4789/udp)
}

# swarm worker:
#   iptables -I INPUT -p tcp --dport 2376 -j ACCEPT
#   iptables -I INPUT -p tcp --dport 7946 -j ACCEPT
#   iptables -I INPUT -p udp --dport 7946 -j ACCEPT
#   iptables -I INPUT -p udp --dport 4789 -j ACCEPT
