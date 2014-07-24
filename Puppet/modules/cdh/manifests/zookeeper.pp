# Installs zookeeper for CDH use
# TODO: Find a way to force deployment on an odd number of nodes.
# Parameters:
## server_id - a number between 1 and 255 that uniquely identifies a zookeeper instance.
class cdh::zookeeper ( $server_id = None ){
  package {
    'zookeeper':
      ensure => installed;
    'zookeeper-server':
      ensure  => installed,
      require => Class['cdh::apt_repository'];
  }

  exec { 'initialize-zookeeper':
    command => "/bin/su -s /bin/bash -c '/usr/bin/zookeeper-server-initialize --myid ${server_id}' - zookeeper",
    onlyif  => '/usr/bin/test ! -f /var/lib/zookeeper/myid',
    require => Package['zookeeper-server'],
  }

  service {
    'zookeeper-server':
      ensure  => running,
      require => [
        Exec['initialize-zookeeper'],
        File['/var/lib/zookeeper'],
        File['/etc/zookeeper/conf.dist/zoo.cfg'],
        Package['zookeeper-server'],
      ];
  }

  file {
    '/var/lib/zookeeper':
      ensure  => directory,
      mode    => '0755',
      owner   => 'zookeeper',
      group   => 'zookeeper',
      require => Package['zookeeper-server'];
    '/etc/zookeeper/conf.dist/zoo.cfg':
      ensure  => present,
      mode    => '0644',
      source  => "puppet:///modules/${module_name}/etc/zookeeper/conf.dist/zoo.cfg",
      owner   => 'root',
      group   => 'root',
      require => Package['zookeeper-server'],
      notify  => Service['zookeeper-server'];
  }
}
