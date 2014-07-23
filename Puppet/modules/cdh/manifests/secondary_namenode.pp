# Class cdh::secondary_namenode - installs a secondary name node.
class cdh::secondary_namenode {
  package {
    'hadoop':
      ensure => installed;
    'hadoop-hdfs-secondarynamenode':
      ensure => installed;
  }
}
