class profile::base {
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

	# add manager pubkey to authorized_keys
	file { '/home/centos/.ssh':
		owner  => 'centos',
		group  => 'centos',
		mode   => '0700',
		ensure => 'directory',
	}
	ssh_authorized_key { 'centos@manager':
		user    => 'centos',
		type    => 'ssh-rsa',
		key     => $::manager_pubkey,
		require => File['/home/centos/.ssh'],
	}

	# add FQDN to DNS
	include ::profile::dns::client
}
