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
		sshkeys::create_ssh_key { 'centos': }
	} else {
		# this will add the pubkey as many times as there are nodes known by puppet,
		# for whatever reason
		@@sshkeys::set_authorized_key { "centos@manager to centos@${::hostname}":
			local_user  => 'centos',
			remote_user => "centos@manager.lab",
		}

		Sshkeys::Set_authorized_key <<||>>
	}

	# add FQDN to DNS
	include ::profile::dns::client

	# TODO: firewall
}

# ssh:
#   iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
