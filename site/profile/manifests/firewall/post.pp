# This class finalizes the firewall rules.

class profile::firewall::post {
	# Drop all traffic not already defined by a rule
	firewall { '999 drop all':
		proto  => 'all',
		action => 'drop',
		before => undef,
	}
}
