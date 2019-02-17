node default {
	# by default, unassigned nodes will be monitored
	include ::role::base
}

node 'manager.tick.lab' {
	include ::role::manager
}
