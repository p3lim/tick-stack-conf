# this class sets up the basic firewall rules
class profile::firewall::pre {
	# wipe existing firewall rules
	Firewall {
		require => undef,
	}

	# default firewall rules
	firewall { '000 accept all icmp':
		proto  => 'icmp',
		action => 'accept',
	}

	firewall { '000 ipv6 accept all icmp':
		proto    => 'icmp',
		action   => 'accept',
		provider => 'ip6tables',
	}

	firewall { '001 accept all to lo interface':
		proto   => 'all',
		iniface => 'lo',
		action  => 'accept',
	}

	firewall { '001 ipv6 accept all to lo interface':
		proto    => 'all',
		iniface  => 'lo',
		action   => 'accept',
		provider => 'ip6tables',
	}

	firewall { '002 reject local traffic not on loopback interface':
		proto       => 'all',
		iniface     => '! lo',
		destination => '127.0.0.1/8',
		action      => 'reject',
	}

	firewall { '002 ipv6 reject local traffic not on loopback interface':
		proto       => 'all',
		iniface     => '! lo',
		destination => '127.0.0.1/8',
		action      => 'reject',
		provider    => 'ip6tables',
	}

	firewall { '003 accept related established rules':
		proto  => 'all',
		state  => ['RELATED', 'ESTABLISHED'],
		action => 'accept',
	}

	firewall { '003 ipv6 accept related established rules':
		proto    => 'all',
		state    => ['RELATED', 'ESTABLISHED'],
		action   => 'accept',
		provider => 'ip6tables',
	}

	firewall { '004 accept incoming SSH':
		proto  => 'tcp',
		dport  => 22,
		action => 'accept',
	}

	firewall { '004 ipv6 accept incoming SSH':
		proto    => 'tcp',
		dport    => 22,
		action   => 'accept',
		provider => 'ip6tables',
	}
}
