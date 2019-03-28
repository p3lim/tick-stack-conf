class role::worker {
	include profile::base
	include profile::swarm::worker
	include profile::influx::telegraf
}
