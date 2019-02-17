class role::manager {
	include profile::base
	include profile::puppetdb
	include profile::dns::server
}
