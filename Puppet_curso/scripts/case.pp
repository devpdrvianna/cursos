case $facts['os']['family'] {
'RedHat': {
package { 'httpd':
ensure => 'installed',
}
}
'Debian': {
package { 'apache2':
ensure => 'installed',
}
}
}
