class profile::firewall {
	Firewall {
		before  => Class['::profile::firewall::post'],
		require => Class['::profile::firewall::pre'],
	}

	class { ['::profile::firewall::pre', '::profile::firewall::post']: }
	class { 'firewall': }
}
