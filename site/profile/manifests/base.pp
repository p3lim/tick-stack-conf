# this class sets up base configuration for all nodes
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

	if $::hostname == 'manager' {
		# create new ssh key so manager can act as a bastion
		sshkeys::create_ssh_key { 'centos': }

		# add our own ssh keys so we can access the machine
		accounts::user { 'centos':
			sshkeys => [
				'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF4NyalXmS0NLlfImsHO4hNM/KPmdlXzvH18iFEItMHaf2Jx7vsublN1IMrEF1Jpwd83D6z0F3lqN8jWzIPSHYuU7w6WQF9BmRUZwtgYXdvYVqz3InnA/3bLaChYD8tPMDdF4bJWO4b6QtXKWT55RCc65k8KTI/jQXUqiCLQoD3IblcKJT8nh0UJCdsubrnDIt14RcrsXBf8xcQ1NJ/vZHFvvW2hH9AlUcMbvdEWRBJiJKvVz1puZZpIBrY3yozeBvpXWtzjbaExhKc+n1dNVIA5nL0dAwNJy8+SJM3rKj5mleE9s2glqdVhGRK+3yF35Jw6nKcniCBy29AAKF++2KP99sBz8tUKgmkmmsqAdoNf4syp9idiUB0zprNQ/5ydP9Lm125yvNAQrdk3p5EpYzOVD2oLE7sE+e5uXV2LWjgUJmZ0ZQb5HTKS5gVCfmJJZfxAHwFJdIZi+uCwSvLSGPATDDvnYNSE9ufGW4A//a5w7/a7O5NNziQAaNXRKemWlG/iHMXt2KstEa5s32w2zzFkLgZgM5uaBNEhBrCtfpXE4YBCrgForEegc1u1zNPBA1S6BHeXBmrNNxMakaeT6wtIUrCqpFut1oBn0DHC0ox4B2056P2Hqn7NJvTUkjMhTMIeoxG8NcNFh1oZUXz6RGe76fFqDokCWoJ69KWhwZaQ== vetle1',
				'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDclkIxS1GDWFzhWUd8KpVLMkOrC01n7xMX+tYyMm+X+iCU/L82VfxWZVyra4RNrrsWzHMBUi2smiw78QR7R2ZKhKR5Aywy409Ph+yTCZkVcCjBX4Qf01fvoECpG5BwatmCNf3r7ne2KoTzIiANQZEzviX+7SPws1KiVpX6uyZ9uAJiD2Zem1O9lW7W/GeoEcy191xV8nB1IeTPissIyG9+0ElVtLRAz6rGYVTc1JCQgk0LhMse+BKd9K/nv21J9UUFa2VAVF15VdRN/2+dQ4iVAU4SjqcgWNpXkpbHB3zoZ9iHOEjZCdhG0GKK6MyZp6Dnwo3rBganQFWLsEKJBtsS2O/e2p/1N/Xpyz8NkttKOHtMt3kMBJzvTV6BRvHIB73QaXxQo6HhpBclCcNYasL8isfHcHOftLnsrg+tBoT5icAK1gi8Dr92QTOsqykww/stSMncaqi9ZN0OrWHFYlKndY+lCHpvmOofb5SL7E5ARdAW007fVlUkrBNEahfVwOEOCUOjfLcjOwR9Of0RU3dSrXTeJTQgnJOQS9jTCawQcdLBj/Q3CWK9VbdJDiOJ3r+40ySBT6iPkuearg6PvegZMDV7h7VHaZlov92kh3/5SHqp8CbktOaYi+eMb+xOn+FfmAw5nm/20QL3E7SilZySDj9YXrI9REOOrvaOcBkkWQ== adrian1',
				'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC0pKvREBwboDpu6amLCclc0YisTNqKCAbD1t/JrZ5WyYh8ms7M2vga3/5Y0zyoxErXEGNnArV3lMgQhvx/OXYn7LA/wdDlk12XgZCxAYYB1hrsEi3w1Cy2XLtNGUuA0XBDxb6XMzyifbGigCWqWm2HRIIdRO/MDJZDi7dAMGH7VFqE6I0e72nBswwYrKv1hvVfzlMsgosz5+h6InIQ0HjhhE8EQuPDVrN2iesaB4Yp4nonTmJANN/ta3tUxhC7RAA86YvnIs4TFVWENVqhkILhq3ol5vr4U80OQ35WqhWnb67z2zLJWJvyhn8dSpJ74ORzzsMmTb1Ei80WreoWMbZGgIH27ICFKi4NDH0OyUhUlvdzxpeYTUGX5VD8+05/s+du/0gm81NlIqrk0E9HpyCdy+m/UlSNRrmSdsUs+MLvsr5M0uNkp7Gky1oRhypN0ZurpyTnY+ejXAmKfuRBqgFmQCpfMvdC2hs2mDfxcE6pP1LH65/goM9bSZgPCphkAU9FRlIfAUzyvw5dQO91z0xGcc5vElv1iXCr/2IdueDPNCL7N9YT373nIjMCbQp/etekE76ytgawFC7W2QOOE9ZROnhY2Acbs5U9PwGL5VZDRdNzDR1ECrKSsxwqfuZUbC4FpD/CV44onVF8Ccy6365odMFUnURgrvvHrIpqwAD86Q== adrian2',
			],
		}
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

	# all nodes are monitored
	# include ::profile::influx::telegraf
}
