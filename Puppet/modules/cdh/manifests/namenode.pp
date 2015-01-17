# Class cdh::namenode - configures the name node service.
class cdh::namenode (
  $zookeeper_server_id = None,
  $namenode_data_dir = '/data/name'
) {

  include 'cdh::node'

  # TODO: Parametrise the Hadoop Name Node HDFS Cache directory (/var/lib/hadoop-hdfs/cache/hdfs/dfs/name)
  # TODO: parametrize and deploy "slaves" and "masters"
  package {
    'hadoop-hdfs-namenode':
      ensure  => installed,
      require => [ Class['Cdh::Node'], Class['Cdh::Apt_repository'] ];
  }

  exec {
    'update-alternatives-hadoop-conf':
      command => '/usr/sbin/update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.production 80',
      onlyif  => '/usr/bin/test "$(/usr/sbin/update-alternatives --query hadoop-conf | awk \'$1 ~ /Value/ {print $2}\')" != \'/etc/hadoop/conf.production\'',
      before  => Service['hadoop-hdfs-namenode'],
      require => Class['Cdh::Datanode'];
    # FIXME: find how to change namenode caching directory.
    'format-hdfs':
      command => '/bin/su -s /bin/bash -c "/usr/bin/hadoop namenode -format" - hdfs',
      onlyif  => "/usr/bin/test ! -e '/var/lib/hadoop-hdfs/cache/hdfs/dfs/name/current'",
      require => [ Class['Cdh::Node'], File[$namenode_data_dir] ];
  }

  service {
    'hadoop-hdfs-namenode':
      ensure  => running,
      require => Exec['format-hdfs'];
  }

  file {
    $namenode_data_dir:
      ensure  => directory,
      owner   => 'hdfs',
      group   => 'hdfs',
      mode    => '0700',
      require => [ Class['Cdh::Node'], Package['hadoop-hdfs-namenode'] ];
  }
}
