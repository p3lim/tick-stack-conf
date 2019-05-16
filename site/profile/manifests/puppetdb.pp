# This class sets up the PuppetDB instance.
# https://forge.puppet.com/puppetlabs/puppetdb

class profile::puppetdb {
	# Configure PuppetDB using the default parameters.
	include puppetdb
	include puppetdb::master::config

	# Accept communication on TCP port 8140 for PuppetDB
	::profile::firewall::management { 'PuppetDB TCP':
		port     => 8140,
		protocol => 'tcp',
	}
}
