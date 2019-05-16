# This class creates and maintains the ICK portion of the TICK stack
# in a Docker Swarm.

class profile::swarm::stack {
	# Copy the templated stack configuration to the node
	file { '/tmp/ick-stack.yaml':
		ensure  => file,
		content => epp('profile/ick-stack.yaml.epp'),
	}

	# Create/maintain the stack from the configuration file
	docker::stack { 'ick':
		stack_name    => 'ick',
		compose_files => ['/tmp/ick-stack.yaml'],
		require       => File['/tmp/ick-stack.yaml'],
	}

	# Open up the firewall for all ports required by ICK
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
