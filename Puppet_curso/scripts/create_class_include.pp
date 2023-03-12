#Definindo Class

class ntpclass {

 #Install Service 
 package { 'ntp':
  ensure => "present"
}
 #Config file
 file { "/etc/ntp.conf":
    ensure => "present",
    content => "server 0.centos.pool.ntp.org iburst\n" 

 }

 #Begin Service
 service { "ntpd":
    ensure => "running",
    enable => "true",
 }

}

#Declaration of a class (se nao incluir não faz nada)
include ntpclass

