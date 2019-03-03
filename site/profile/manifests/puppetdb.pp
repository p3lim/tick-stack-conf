# https://forge.puppet.com/puppetlabs/puppetdb

# this class sets up the PuppetDB instance
class profile::puppetdb {
	include puppetdb
	include puppetdb::master::config

	# firewall
	::profile::firewall::management { 'PuppetDB TCP':
		port     => 8140,
		protocol => 'tcp',
	}
}
