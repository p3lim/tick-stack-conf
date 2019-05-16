# This class is used to open up the firewall for the given service on the management network,
# used by other profiles to define their own rules.

define profile::firewall::management (
	Variant[Integer, Array[Integer], String] $port,
	String                                   $protocol,
){
	# Make sure the base profile is loaded
	require ::profile::firewall

	# Set up the firewall policy
	firewall { "5 Accept service ${name} from ${net}":
		proto  => $protocol,
		dport  => $port,
		action => 'accept',
		source => '192.168.0.0/16',
	}
}
