class profile::r10k {
	# just make sure r10k pulls every 30 minutes

	cron { 'r10k':
		command => '/bin/r10k deploy environment -p',
		user    => 'root',
		minute  => '*/30',
	}
}
