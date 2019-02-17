class profile::base {
	$root_ssh_key = lookup('base::root_ssh_key')

	# setup time and date
	class { 'ntp':
		servers  => ['ntp.ntnu.no'],
		restrict => [
			'default kod nomodify notrap nopeer noquery',
			'-6 default kod nomodify notrap nopeer noquery',
		],
	}
	class { 'timezone':
		timezone => 'Europe/Oslo',
	}

	# add FQDN to DNS
	include ::profile::dns::client
}
