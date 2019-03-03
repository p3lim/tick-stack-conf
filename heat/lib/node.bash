#!/bin/bash -v

# add manager to our hosts file ('manager_ip_address' is a template variable for Heat)
echo "manager_ip_address manager.lab manager" >> /etc/hosts

# correct the hostname and FQDN
echo "$(hostname -I) $(hostname -s).lab $(hostname -s)" >> /etc/hosts
hostnamectl set-hostname $(hostname -s).lab
systemctl restart systemd-hostnamed
systemctl restart network

# install puppet
rpm -Uvh https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
yum install -y puppet-agent

# update path (this will be fixed after a reboot)
PATH=$PATH:/opt/puppetlabs/bin

# stop puppet in case it's already running
puppet resource service puppet ensure=stopped enable=true

# configure the puppet's interval and master, then run it
puppet config set server manager.lab --section main
puppet config set runinterval 300 --section main
puppet agent -t # request certificate
puppet agent -t # configure

# enable and start puppet
puppet resource service puppet ensure=running enable=true

# manually control resolvd, setting the correct nameserver
echo "PEERDNS=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "search lab" > /etc/resolv.conf
echo "nameserver dns_ip_address" >> /etc/resolv.conf
systemctl restart network

#wc notify --data-binary '{"status": "SUCCESS"}'
