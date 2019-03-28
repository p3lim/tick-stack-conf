# == Class: profile::monotick
#
class profile::monotick {
  $telegraf_user = lookup('monolithic::telegraf_user')
  $telegraf_pass = lookup('monolithic::telegraf_pass')

  include tick_stack::influxdb
  include tick_stack::chronograf
  include tick_stack::kapacitor

  class { 'tick_stack::telegraf':
    inputs => {
      'cpu' => {
        'percpu'   => true,
        'totalcpu' => true,
      },
      'system' => {},
      'memory' => {}
    },
    outputs => {
			'influxdb' => {
				'urls'      => "[\"http://127.0.0.1:8086\"]",
				'database'  => '"telegraf"',
				'precision' => '"s"',
				'username'  => "\"${telegraf_user}\"",
				'password'  => "\"${telegraf_pass}\"",
			}
		}
  }
}