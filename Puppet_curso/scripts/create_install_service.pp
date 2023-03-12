#codigo Install and Running Service
package { 'ntp':
  ensure => "present"
}

file { "/etc/ntp.conf":
    ensure => "present",
    content => "server 0.centos.pool.ntp.org iburst\n" 

}

service { "ntpd":
    ensure => "running",
}
