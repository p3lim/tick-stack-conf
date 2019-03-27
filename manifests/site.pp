node default {
	include profile::base
}

node 'manager.lab' {
	include ::role::manager
}

node 'master.lab' {
	include ::role::master
}

node /^worker-\d+\.lab$/ {
	include ::role::worker
}

node 'monotick' {
	include ::role::monolithic
}
