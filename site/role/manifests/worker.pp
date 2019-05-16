# Worker role, for nodes participating as workers in Docker Swarm.
# Uses the base profile, then joins the swarm as a worker and gets monitored by Telegraf.

class role::worker {
	include profile::base
	include profile::swarm::worker
	include profile::influx::telegraf
}
