# Class datanode - installs a data node
class cdh::datanode {

  include 'cdh::node'

  # TODO: Deploy Hadoop Data-Node-specific configuraton with the software.
  package {
    'hadoop-hdfs':
      ensure  => installed,
      require => Class['Cdh::Apt_repository'];
    'hadoop-hdfs-datanode':
      ensure  => installed,
      require => Class['Cdh::Apt_repository'];
  }

  service {
    'hadoop-hdfs-datanode':
      ensure  => running,
      require => [
        Package['hadoop-hdfs'],
        Class['Cdh::Node'],
      ]
  }

  file {
    '/data/hdfs':
      ensure  => directory,
      owner   => 'hdfs',
      group   => 'hdfs',
      mode    => '0700',
      require => [ Class['Cdh::Node'], Package['hadoop-hdfs'] ];
  }

}
