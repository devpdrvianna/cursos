$directories = [
'/tmp',
'/tmp/example1',
'/tmp/example2',
'/tmp/example1/foo',
'/tmp/example1/bar',
]
file { $directories:
ensure => 'directory',
mode => '0755',
}
