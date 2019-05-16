# This class sets up the firewall using sub-classes for pre/post configuration.
class profile::firewall {
	# Define the before and after sub-classes
	Firewall {
		before  => Class['::profile::firewall::post'],
		require => Class['::profile::firewall::pre'],
	}

	# Include the sub-classes
	class { ['::profile::firewall::pre', '::profile::firewall::post']: }

	# Set up the firewall
	include firewall
}
