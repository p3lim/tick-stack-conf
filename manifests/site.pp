node default {
	file { '/tmp/helloworld':
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		content => 'hello\n',
	}
}
