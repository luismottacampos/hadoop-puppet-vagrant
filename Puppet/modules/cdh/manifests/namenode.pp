# Class cdh::namenode - configures the name node service.
class cdh::namenode {

  class{
    'cdh::datanode':;
  }

  # TODO: Deploy configuration
  # TODO: Deploy ZooKeeper failover controller daemon + configuration
  package {
    'hadoop-hdfs-namenode':
      ensure  => installed,
      require => Class['cdh::apt_repository'];
  }
}
