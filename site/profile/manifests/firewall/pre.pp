# This class sets up the basic firewall rules.

class profile::firewall::pre {
	# Wipe existing firewall rules
	Firewall {
		require => undef,
	}

	# Set default firewall rules
	firewall { '000 accept all icmp':
		proto  => 'icmp',
		action => 'accept',
	}

	firewall { '001 accept all to lo interface':
		proto   => 'all',
		iniface => 'lo',
		action  => 'accept',
	}

	firewall { '002 reject local traffic not on loopback interface':
		proto       => 'all',
		iniface     => '! lo',
		destination => '127.0.0.1/8',
		action      => 'reject',
	}

	firewall { '003 accept related established rules':
		proto  => 'all',
		state  => ['RELATED', 'ESTABLISHED'],
		action => 'accept',
	}

	firewall { '004 accept incoming SSH':
		proto  => 'tcp',
		dport  => 22,
		action => 'accept',
	}
}
