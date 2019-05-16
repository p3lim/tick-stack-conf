# TICK control-repo

This repository contains the Puppet control-repo for installing TICK in both monolithic and distributed implementations on OpenStack. Heat templates are used to orchestrate the infrastructure, with Puppet as a provisioner.

It will set up NTP, DNS, firewalls, PuppetDB and r10k, along with TICK straight from binary packages and in a Docker Swarm using official images.
