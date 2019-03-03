# this class sets up the firewall
class profile::firewall {
	Firewall {
		before  => Class['::profile::firewall::post'],
		require => Class['::profile::firewall::pre'],
	}

	class { ['::profile::firewall::pre', '::profile::firewall::post']: }
	class { 'firewall': }
}
