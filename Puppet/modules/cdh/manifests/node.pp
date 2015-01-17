# Node is the base node of the CDH hosts.
class cdh::node {
  class {
    'base':;
    'jdk':;
    'cdh::apt_repository':;
  }

  package {
    'hadoop':
      ensure  => installed,
      require => Class['Cdh::Apt_repository'];
  }

  file {
    ['/etc/hadoop', '/etc/hadoop/conf.production']:
      ensure  => directory,
      owner   => 'root',
      group   => 'hadoop',
      mode    => '0755',
      require => Package['hadoop'];
    '/etc/hadoop/conf.production/core-site.xml':
      ensure  => present,
      owner   => 'root',
      group   => 'hadoop',
      source  => "puppet:///modules/${module_name}/etc/hadoop/conf.production/core-site.xml",
      require => File['/etc/hadoop/conf.production'];
    '/etc/hadoop/conf.production/hdfs-site.xml':
      ensure  => present,
      owner   => 'root',
      group   => 'hadoop',
      source  => "puppet:///modules/${module_name}/etc/hadoop/conf.production/hdfs-site.xml",
      require => File['/etc/hadoop/conf.production'];
    '/etc/hadoop/conf.production/log4j.properties':
      ensure  => present,
      owner   => 'root',
      group   => 'hadoop',
      source  => "puppet:///modules/${module_name}/etc/hadoop/conf.production/log4j.properties",
      require => File['/etc/hadoop/conf.production'];
    '/data':
      ensure  => directory,
      owner   => 'root',
      group   => 'root';
  }
}
