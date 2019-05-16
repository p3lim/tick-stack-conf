# This class installs, configures and runs Telegraf on the given node

class profile::influx::telegraf {
	# Get Telegraf parameters from Hiera
	$influx_user = lookup('influx::telegraf_user')
	$influx_pass = lookup('influx::telegraf_pass')

	# Install Telegraf with custom inputs and report to InfluxDB locally
	class { 'tick_stack::telegraf':
		inputs => {
			'cpu' => {
				'percpu'   => true,
				'totalcpu' => true,
			},
			'system'    => {},
			'mem'       => {},
			'net'       => {},
			'netstat'   => {},
			'processes' => {},
			'procstat'  => {
				'pattern' => '"influx|kapa*"',
			},
		},
		outputs => {
			'influxdb' => {
				'urls'      => "[\"http://master.lab:8086\"]",
				'database'  => '"telegraf"',
				'precision' => '"s"',
				'username'  => "\"${influx_user}\"",
				'password'  => "\"${influx_pass}\"",
			}
		}
	}
}
