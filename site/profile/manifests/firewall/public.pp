define profile::firewall::public (
	Variant[Integer, Array[Integer], String] $port,
	String                                   $protocol,
){
	require ::profile::firewall

	firewall { "5 Accept service ${name} from ${net}":
		proto  => $protocol,
		dport  => $port,
		action => 'accept',
	}

	firewall { "5 Accept service ${name} from ${net}":
		proto    => $protocol,
		dport    => $port,
		action   => 'accept',
		provider => 'ip6tables',
	}
}
