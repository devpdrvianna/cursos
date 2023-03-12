$packages = [‘vim’, ‘git’, ‘curl’]

$packages.each |String $package| {
package { $package:
ensure => “installed”
}
}
