# Monolithic role, for the node running TICK entirely.
# Uses the base profile, then sets up the entire TICK stack.

class role::monolithic {
  include profile::base
  include profile::monotick
}
