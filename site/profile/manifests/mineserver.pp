class profile::mineserver {
  
file { '/opt/minecraft':
  ensure => 'directory',
     }
file { '/opt/minecraft/server.jar':
  ensure => file,
  source => 'https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar',
  replace => false,
     }
  
file {'/opt/minecraft/eula.txt':
  ensure => file,
  content => 'eula=true'
     }
  
file { '/etc/systemd/system/mineserver.service':
  ensure => file,
  source => 'puppet:///modules/mineserver/mineserver.service',
  owner => 'root',
  group => 'root',
  mode  => '0644',
     }
  
  service {'mineserver':
  ensure => running,
  enable => true,
          }
}
