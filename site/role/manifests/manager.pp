# Manager role, for the node acting as the manager for the entire infrastructure.
# Uses the base profile, runs PuppetDB and the DNS server, and gets monitored by Telegraf.

class role::manager {
	include profile::base
	include profile::puppetdb
	include profile::dns::server
	include profile::influx::telegraf
	#include profile::r10k
}
