node default {
	include profile::base
}

node 'manager.lab' {
	include ::role::manager
}

node /^worker-\d+\.lab$/ {
	include ::role::worker
}
