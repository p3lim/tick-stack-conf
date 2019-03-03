class profile::swarm::stack {
	file { '/tmp/ick-stack.yaml':
		ensure  => file,
		content => epp('profile/ick-stack.yaml.epp'),
	}

	docker::stack { 'ick':
		stack_name    => 'ick',
		compose_files => ['/tmp/ick-stack.yaml'],
		require       => File['/tmp/ick-stack.yaml'],
	}

	# TODO: firewall
}

# InfluxDB:
#   iptables -I INPUT -p tcp --dport 8086 -j ACCEPT
# Kapacitor
#   iptables -I INPUT -p tcp --dport 9092 -j ACCEPT
# Chronograf:
#   iptables -I INPUT -p tcp --dport 8888 -j ACCEPT
