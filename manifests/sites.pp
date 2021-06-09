node default {
}

node 'slave1.puppet' {

package { 'httpd': ensure => 'installed' }

service { 'httpd':
  ensure => running,
  enable => true,
        }

file { '/root/README':
      ensure => absent,
     }

file { '/var/www/site1/index.html':
      ensure => file,
      source => '/vagrant/index.html',
      replace => true,
      }

file { '/etc/httpd/conf.d/site1.conf':
      ensure => file,
      source => '/vagrant/site1.conf',
      replace => true,
      }

service { 'httpd':
  ensure => restarted,
        }
}

node 'slave2.puppet' {

$packages = [ 'httpd', 'php' ]
package { $packages: ensure => 'installed' }

service { 'httpd':
  ensure => running,
  enable => true,
        }

file { '/root/README':
      ensure => absent,
     }

file { '/var/www/site2/index.php':
      ensure => file,
      source => '/vagrant/index.php',
      replace => true,
      }

file { '/etc/httpd/conf.d/site2.conf':
      ensure => file,
      source => '/vagrant/site2.conf',
      replace => true,
      }

service { 'httpd':
  ensure => restarted,
        }
}        
