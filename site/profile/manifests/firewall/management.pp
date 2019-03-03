# this class is used to open up the firewall for the given service on all networks
define profile::firewall::management (
	Variant[Integer, Array[Integer], String] $port,
	String                                   $protocol,
){
	require ::profile::firewall

	firewall { "5 Accept service ${name} from ${net}":
		proto  => $protocol,
		dport  => $port,
		action => 'accept',
		source => '192.168.0.0/16',
	}

	firewall { "5 Accept service ${name} from ${net}":
		proto    => $protocol,
		dport    => $port,
		action   => 'accept',
		source   => '192.168.0.0/16',
		provider => 'ip6tables',
	}
}
