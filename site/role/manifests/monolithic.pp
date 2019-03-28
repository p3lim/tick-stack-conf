# == Class: role::monolithic
#
class role::monolithic {
  # resources
  include profile::base
  include profile::monotick
}
