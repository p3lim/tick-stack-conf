# this class finalizes the firewall rules
class profile::firewall::post {
	firewall { '999 drop all':
		proto  => 'all',
		action => 'drop',
		before => undef,
	}

	firewall { '999 ipv6 drop all':
		proto    => 'all',
		action   => 'drop',
		before   => undef,
		provider => 'ip6tables',
	}
}
