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
	if $::hostname == 'manager' {
		sshkeys::create_ssh_key { 'centos':
			create_ssh_dir => false,
		}
	} else {
		@@sshkeys::set_authorized_key { "centos@${::hostname}":
			local_user  => 'centos',
			remote_user => "centos@manager.lab",
		}
	}

	Sshkeys::Set_authorized_key <<||>>

	# add FQDN to DNS
	include ::profile::dns::client
}
