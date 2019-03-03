class profile::r10k {
	class { 'r10k':
		version => latest,
		sources => {
			'puppet' => {
				'remote'  => 'https://github.com/p3lim/tick-stack-conf.git',
				'basedir' => '/etc/puppetlabs/code/environments',
				'prefix'  => false,
			},
		},
	}

	# just make sure r10k pulls every 30 minutes
	cron { 'r10k':
		command => '/bin/r10k deploy environment -p',
		user    => 'root',
		minute  => '*/30',
	}
}
