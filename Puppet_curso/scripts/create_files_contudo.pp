file {
default:
ensure => 'file',
owner  => 'root',
mode   => '0444',
group  => 'root',
;

'/etc/puppetlabs/puppet/puppet.conf1':
content => template('puppet/puppet.conf1.erb1'),
group => 'wheel',
;
'/etc/puppetlabs/puppet/auth.conf1':
content => template('puppet/auth.conf1.erb1'),
mode => '0400',
;
'/etc/puppetlabs/puppet/routes.yaml1':
content => template('puppet/routes.yaml.erb1'),
;
}
