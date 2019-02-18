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

	unless $::fqdn == 'manager.lab' {
		# add manager pubkey to authorized_keys
		sshkeys::set_authorized_key { "centos@manager to centos@${::hostname}":
		  local_user  => 'centos',
		  remote_user => 'centos@manager',
		}
	} else {
		# create a ssh key for the manager
		sshkeys::create_ssh_key { 'centos': }
	}

	# add FQDN to DNS
	include ::profile::dns::client
}
