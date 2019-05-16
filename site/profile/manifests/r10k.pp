# This class sets up the r10k service, which pulls the configuration from the public repository
# on GitHub.

class profile::r10k {
	# Configure r10k to pull from GitHub to the local environments directory
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

	# Configure r10k to pull changes every 30 minutes
	cron { 'r10k':
		command => '/bin/r10k deploy environment -p',
		user    => 'root',
		minute  => '*/30',
	}
}
