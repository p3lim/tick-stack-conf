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

	# firewall
	::profile::firewall::management { 'InfluxDB TCP':
		port     => 8086,
		protocol => 'tcp',
	}

	::profile::firewall::management { 'Kapacitor TCP':
		port     => 9092,
		protocol => 'tcp',
	}

	::profile::firewall::public { 'Chronograf TCP':
		port     => 8888,
		protocol => 'tcp',
	}
}
