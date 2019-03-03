# this class installs, configures and runs Telegraf on the given node
class profile::influx::telegraf {
	$master    = puppetdb_query('inventory[facts] {facts.trusted.certname ~ "master"}')
	$master_ip = $master[0]['facts']['ipaddress']

	$influx_user = lookup('influx::telegraf_user')
	$influx_pass = lookup('influx::telegraf_pass')

	class { 'tick_stack::telegraf':
		inputs => {
			'cpu' => {
				'percpu'   => true,
				'totalcpu' => true,
			}
			'system' => {}
		},
		outputs => {
			'influxdb' => {
				'urls'      => "[\"http://${master_ip}:8086\"]",
				'database'  => '"telegraf"',
				'precision' => '"s"',
				'username'  => "\"${influx_user}\"",
				'password'  => "\"${influx_pass}\"",
			}
		}
	}
}
