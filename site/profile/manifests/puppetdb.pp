# https://forge.puppet.com/puppetlabs/puppetdb

class profile::puppetdb {
	include puppetdb
	include puppetdb::master::config
}
