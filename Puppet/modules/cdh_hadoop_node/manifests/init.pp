# The main class for CDH Nodes governed by Puppet
class cdh_hadoop_node {
  class {
    'cdh_hadoop_node::apt':;
    'cdh_hadoop_node::hosts':;
    'cdh_hadoop_node::ssh_keys':;
    'jdk':;
  }

  #   package {
  #     'hadoop':
  #       ensure  => installed,
  #       require => Class['cdh_hadoop_node::apt'];
  #     'hadoop-hdfs-namenode':
  #       ensure  => installed,
  #       require => Class['cdh_hadoop_node::apt'];
  #     'hadoop-hdfs-datanode':
  #       ensure  => installed,
  #       require => Class['cdh_hadoop_node::apt'];
  #     'hadoop-hdfs-secondarynamenode':
  #       ensure  => installed,
  #       require => Class['cdh_hadoop_node::apt'];
  #     'hadoop-yarn-resourcemanager':
  #       ensure  => installed,
  #       require => Class['cdh_hadoop_node::apt'];
  #     'hadoop-yarn-nodemanager':
  #       ensure  => installed,
  #       require => Class['cdh_hadoop_node::apt'];
  #     'hadoop-mapreduce-historyserver':
  #       ensure  => installed,
  #       require => Class['cdh_hadoop_node::apt'];
  #     'flume-ng':
  #       ensure  => installed,
  #       require => Class['cdh_hadoop_node::apt'];
  #   }
}
