# https://forge.puppet.com/puppetlabs/puppetdb

class profile::puppetdb {
	include puppetdb
	include puppetdb::master::config

	# TODO: firewall
}

# puppetdb:
#   iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 8140 -j ACCEPT
