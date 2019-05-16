# This class sets up TICK on a single machine.

class profile::monotick {
  # Get Telegraf parameters from Hiera
  $telegraf_user = lookup('influx::telegraf_user')
  $telegraf_pass = lookup('influx::telegraf_pass')

  # Install InfluxDB, Chronograf and Kapacitor using default configuration values
  include tick_stack::influxdb
  include tick_stack::chronograf
  include tick_stack::kapacitor

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
        'urls'      => "[\"http://127.0.0.1:8086\"]",
        'database'  => '"telegraf"',
        'precision' => '"s"',
        'username'  => "\"${telegraf_user}\"",
        'password'  => "\"${telegraf_pass}\"",
      }
    }
  }
}
