#!/bin/bash -v

# correct the hostname and FQDN
echo "$(hostname -I) $(hostname -s).lab $(hostname -s)" >> /etc/hosts
hostnamectl set-hostname $(hostname -s).lab
systemctl restart systemd-hostnamed

# update search resolvd's search prefix
/etc/init.d/network restart

# install puppetserver
rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
yum install -y puppetserver

# update path (this will be fixed after a reboot)
PATH=$PATH:/opt/puppetlabs/bin

# stop puppet and puppetserver in case they're already running
puppet resource service puppet ensure=stopped enable=true
puppet resource service puppetserver ensure=stopped enable=true

# configure the agent's interval and master, and enable auto-signing
puppet config set server manager.lab --section main
puppet config set runinterval 300 --section main
puppet config set autosign true --section main

# install, configure and apply r10k
puppet module install puppet-r10k
cat <<EOF > /var/tmp/r10k.pp
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
EOF
puppet apply /var/tmp/r10k.pp

# generate ssh keys for the centos user
ssh-keygen -t rsa -b 4096 -C "manager" -N '' -q -f '/home/centos/.ssh/id_rsa'
chown centos:centos /home/centos/.ssh/id_rsa*

# add the pubkey as a fact
mkdir -p /etc/puppetlabs/facter/facts.d/
echo "manager_pubkey=$(cut -d ' ' -f 2 /home/centos/.ssh/id_rsa.pub)" >> /etc/puppetlabs/facter/facts.d/pubkey.txt

# run r10k
r10k deploy environment -p

# start the Puppet server and bootstrap the Puppet client
puppet resource service puppetserver ensure=running enable=true
puppet agent -t # request certificate
puppet agent -t # configure manager
puppet agent -t # once more to update exported resources
puppet resource service puppet ensure=running enable=true

# set firewall rules for DNS and puppetserver
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 53 -j ACCEPT
iptables -I INPUT -p udp -m state --state NEW -m udp --dport 53 -j ACCEPT
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 8140 -j ACCEPT
/sbin/service iptables save

# set ourselves as the DNS server (since we're running BIND9)
echo "DNS1=127.0.0.1" >> /etc/sysconfig/network-scripts/ifcfg-eth0
/etc/init.d/network restart

#wc notify --data-binary '{"status": "SUCCESS"}'
