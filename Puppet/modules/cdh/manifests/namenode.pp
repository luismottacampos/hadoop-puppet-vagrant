# Class cdh::namenode - configures the name node service.
class cdh::namenode {

  class{
    'base':;
    'jdk':;
    'cdh::apt_repository':;
  }

  # TODO: Deploy configuration
  # TODO: Deploy ZooKeeper failover controller daemon + configuration
  package {
    'hadoop':
      ensure  => installed,
      require => Class['cdh::apt_repository'];
    'hadoop-hdfs':
      ensure  => installed,
      require => Class['cdh::apt_repository'];
    'hadoop-hdfs-namenode':
      ensure  => installed,
      require => Class['cdh::apt_repository'];
  }
}
