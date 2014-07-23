# Class cdh::namenode - configures the name node service.
class cdh::namenode {
  package {
    'hadoop-hdfs-namenode':
      ensure  => installed,
      require => Class['cdh_hadoop_node::apt'];
  }
}
