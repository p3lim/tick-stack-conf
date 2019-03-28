class role::manager {
	include profile::base
	include profile::puppetdb
	include profile::dns::server
	include profile::influx::telegraf
	#include profile::r10k
}
