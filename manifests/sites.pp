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

file { '/var/www/site1': 
    ensure => 'directory', 
  }

file { '/var/www/site1/index.html':
      ensure => file,
      source => 'puppet:///modules/dev_web/index.html',
      replace => true,
      }

file { '/etc/httpd/conf.d/site1.conf':
      notify  => Service['httpd'],
      ensure => file,
      source => 'puppet:///modules/dev_conf/site1.conf',
      replace => true,
      }
}

node 'slave2.puppet' {

include stdlib

$packages = [ 'httpd', 'php' ]
package { $packages: ensure => 'installed' }

service { 'httpd':
  ensure => running,
  enable => true,
        }

file_line { 'replace Listen 81':
  replace => true,
  path => '/etc/httpd/conf/httpd.conf',
  line => 'Listen 81',
  match  => 'Listen 80',
}

file { '/root/README':
      ensure => absent,
     }

file { '/var/www/site2': 
    ensure => 'directory', 
  }

file { '/var/www/site2/index.php':
      ensure => file,
      source => 'puppet:///modules/dev_web/index.php',
      replace => true,
      }

file { '/etc/httpd/conf.d/site2.conf':
      notify  => Service['httpd'],
      ensure => file,
      source => 'puppet:///modules/dev_conf/site2.conf',
      replace => true,
      }
}        

node 'master.puppet' {

include nginx

nginx::resource::server { 'proxy-master':
    listen_port => 80,
    proxy       => 'http://192.168.33.12:81',
                        }
                     }
