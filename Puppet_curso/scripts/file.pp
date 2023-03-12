File {
mode => '0440',
owner => 'nobody',
group => 'nobody',
}
file { '/tmp/foo.txt':
content => 'Foo',
}
file { '/tmp/bar.txt':
content => 'Bar',
}
