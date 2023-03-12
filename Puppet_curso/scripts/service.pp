package { 'httpd':
ensure => 'installed',
}
 file { '/etc/httpd/conf.d/httpd.conf':
ensure => 'present',
group => 'httpd',
mode => '0440',
}
 service { 'httpd':
ensure => 'running'
enable => true,
}
