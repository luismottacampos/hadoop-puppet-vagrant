# Class datanode - installs a data node
class cdh::datanode {
  package {
    'hadoop':
      ensure => installed;
    'hadoop-hdfs-datanode':
      ensure => installed;
  }
}
