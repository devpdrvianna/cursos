Exec { path => [ “/bin/”, “/sbin/” , “/usr/bin/”, “/usr/sbin/” ] }

exec { “system-update”:
command => “apt-get update”,
onlyif => “test $(facter uptime_seconds) -lt 300”,
}

package { “wget”:
ensure => present,
}

package { “php5”:
require => Exec[“system-update”], # exige ‘apt-update’ antes da instalação
ensure => installed,
}

package { “apache2”:
ensure => present,
require => Exec[“system-update”],
}

package { “php5-mysql”:
ensure => latest,
require => Exec[“system-update”],
}

service { “apache2”:
ensure => “running”,
enable => “true”,
require => Package[“apache2”],
}

#Vamos instalar o wordpress, precisamos definir o diretório
$install_dir = ‘/var/www/html/wp’
$dir = [ ‘/var/www’,
‘/var/www/html’,
‘/var/www/html/wp’,
]

file { $dir:
ensure => directory,
}

file { “${install_dir}/wp-config-sample.php”:
ensure => present,
}

exec { ‘Download wordpress’:
command => “wget http://wordpress.org/latest.tar.gz -O /tmp/wp.tar.gz”,
creates => “/tmp/wp.tar.gz”,
require => [ File[“${install_dir}”], Package[“wget”] ],
} ->
exec { ‘Extract wordpress’:
command => “sudo tar zxvf /tmp/wp.tar.gz –strip-components=1 -C ${install_dir}”,
creates => “${install_dir}/index.php”,
require => Exec[“Download wordpress”],
} ->
exec { “copy_def_config”:
command => “cp ${install_dir}/wp-config-sample.php ${install_dir}/wp-config.php”,
creates => “${install_dir}/wp-config.php”,
require => File[“${install_dir}/wp-config-sample.php”],
} ->
file_line { ‘db_name_line’:
path => “${install_dir}/wp-config.php”,
line => “define(‘DB_NAME’, ‘wordpress_db’);”,
match => “^define\\(‘DB_NAME*”,
} ->
file_line { ‘db_user_line’:
path => “${install_dir}/wp-config.php”,
line => “define(‘DB_USER’, ‘wordpress_user’);”,
match => “^define\\(‘DB_USER*”,
} ->
file_line { ‘db_password_line’:
path => “${install_dir}/wp-config.php”,
line => “define(‘DB_PASSWORD’, ‘wordpress’);”,
match => “^define\\(‘DB_PASSWORD*”,
} ->



#Continue da seguinte forma:


file_line { ‘db_host_line’:
path => “${install_dir}/wp-config.php”,
line => “define(‘DB_HOST’, ‘localhost’);”,
match => “^define\\(‘DB_HOST*”,
}
exec { “enable-php-module”:
command => “sudo a2enmod php5”,
unless => “grep php5 /etc/sysconfig/apache2”,
require => Package[“php5”],
notify => Service[“apache2”],
}
package { “mysql-server”:
ensure => installed,
}
service { “mysql”:
ensure => “running”,
enable => “true”,
require => Package[“mysql-server”],
}

$mysql_password = “testing”
$db_name = “wordpress_db”
$db_user = “wordpress_user”
$db_pass = “wordpress”
$db_access = “localhost”

exec { “set-mysql-password”:
unless => “mysqladmin -u root -p\”$mysql_password\” status”,
command => “mysqladmin -u root password \”$mysql_password\””,
require => [ Package[“mysql-server”], Service[“mysql”] ]
}

exec { “create-wordpress-db”:
unless => “mysql -uroot -p$mysql_password ${db_name}”,
command => “mysql -uroot -p$mysql_password -e \” create database ${db_name}; grant all on ${db_name}.* to ${db_user}@’$db_access’ identified by ‘$db_pass’;\””,
require => [ Package[“mysql-server”], Service[“mysql”], Exec[“set-mysql-password”] ]
}
