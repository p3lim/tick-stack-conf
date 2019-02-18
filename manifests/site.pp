node default {
  include profile::base
}

node 'manager.tick.lab' {
	include ::role::manager
}
