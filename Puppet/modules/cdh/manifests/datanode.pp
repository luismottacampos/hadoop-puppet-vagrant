# Class datanode - installs a data node
class cdh::datanode {

  class { 'cdh::node':; }

  # TODO: Deploy Hadoop Data-Node-specific configuraton with the software.
  package {
    'hadoop-hdfs':
      ensure  => installed,
      require => Class['cdh::apt_repository'];
  }
}
