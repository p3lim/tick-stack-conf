# this class finalizes the firewall rules
class profile::firewall::post {
	firewall { '999 drop all':
		proto  => 'all',
		action => 'drop',
		before => undef,
	}
}
