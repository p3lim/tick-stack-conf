# Master role, for nodes participating as masters in Docker Swarm.
# Uses the base profile, then starts the swarm, creates the (T)ICK stack and gets monitored by Telegraf.

class role::master {
	include profile::base
	include profile::swarm::manager
	include profile::swarm::stack
	include profile::influx::telegraf
}
