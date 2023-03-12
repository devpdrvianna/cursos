file { "/tmp/testdir":
	ensure => "directory",
}


file { "/tmp/testdir/testfile":
	ensure => "present",
	owner => "homeuser",
	group => "homeuser",
	mode => "0644",
}
