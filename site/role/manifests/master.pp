class role::master {
	include profile::base
	include profile::swarm::manager
	include profile::swarm::stack
}
