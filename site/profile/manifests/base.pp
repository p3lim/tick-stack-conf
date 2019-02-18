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

	unless $::fqdn == 'manager.tick.lab' {
		# add manager pubkey to authorized_keys
		file { '/root/.ssh':
			ensure => 'directory',
			owner  => 'root',
			group  => 'root',
			mode   => '0700',
		}
		ssh_authorized_key { 'root@manager':
			user    => 'root',
			type    => 'ssh-rsa',
			key     => lookup('base::manager_pubkey'),
			require => File['/root/.ssh'],
		}
	}

	# add FQDN to DNS
	include ::profile::dns::client
}
