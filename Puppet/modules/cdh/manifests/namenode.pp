# Class cdh::namenode - configures the name node service.
class cdh::namenode ( $zookeeper_server_id = None ) {

  class{
    'cdh::datanode':;
    'cdh::zookeeper':
      server_id => $zookeeper_server_id;
  }

  # TODO: Deploy configuration
  # TODO: Deploy ZooKeeper failover controller daemon + configuration
  package {
    'hadoop-hdfs-namenode':
      ensure  => installed,
      require => Class['cdh::apt_repository'];
  }
}
