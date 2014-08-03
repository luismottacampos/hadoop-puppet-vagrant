# Class cdh::namenode - configures the name node service.
class cdh::namenode ( $zookeeper_server_id = None ) {

  class{
    'cdh::datanode':;
    'cdh::zookeeper':
      server_id => $zookeeper_server_id;
  }

  # TODO: Deploy configuration
  # TODO: Deploy ZooKeeper failover controller daemon + configuration
  # TODO: Parametrise the Hadoop Name Node HDFS Cache directory (/var/lib/hadoop-hdfs/cache/hdfs/dfs/name)
  # TODO: parametrize and deploy "slaves" and "masters"
  package {
    'hadoop-hdfs-namenode':
      ensure  => installed,
      require => Class['cdh::apt_repository'];
  }

  exec {
    'update-alternatives-hadoop-conf':
      command => '/usr/sbin/update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.production 80',
      onlyif  => '/usr/bin/test "$(/usr/sbin/update-alternatives --query hadoop-conf | awk \'$1 ~ /Value/ {print $2}\')" != \'/etc/hadoop/conf.production\'',
      before  => Service['hadoop-hdfs-namenode'],
      require => [
        File['/etc/hadoop/conf.production/core-site.xml'],
        File['/etc/hadoop/conf.production/hdfs-site.xml']
      ];
    'format-hdfs':
      command => '/bin/su -s /bin/bash -c "/usr/bin/hadoop namenode -format" - hdfs',
      onlyif  => '/usr/bin/test ! -e /var/lib/hadoop-hdfs/cache/hdfs/dfs/name',
      require => [
        File['/etc/hadoop/conf.production/core-site.xml'],
        File['/etc/hadoop/conf.production/hdfs-site.xml']
      ];
  }

  service {
    'hadoop-hdfs-namenode':
      ensure  => running,
      require => Exec['format-hdfs'];
  }

  file {
    ['/etc/hadoop', '/etc/hadoop/conf.production']:
      ensure  => directory,
      owner   => 'root',
      group   => 'hadoop',
      mode    => '0755',
      require => Package['hadoop-hdfs-namenode'];
    '/etc/hadoop/conf.production/core-site.xml':
      ensure  => present,
      owner   => 'root',
      group   => 'hadoop',
      require => File['/etc/hadoop/conf.production'],
      source  => "puppet:///modules/${module_name}/etc/hadoop/conf.production/core-site.xml",
      notify  => Service['hadoop-hdfs-namenode'];
    '/etc/hadoop/conf.production/hdfs-site.xml':
      ensure  => present,
      owner   => 'root',
      group   => 'hadoop',
      require => File['/etc/hadoop/conf.production'],
      source  => "puppet:///modules/${module_name}/etc/hadoop/conf.production/hdfs-site.xml",
      notify  => Service['hadoop-hdfs-namenode'];
    '/etc/hadoop/conf.production/log4j.properties':
      ensure  => present,
      owner   => 'root',
      group   => 'hadoop',
      require => File['/etc/hadoop/conf.production'],
      source  => "puppet:///modules/${module_name}/etc/hadoop/conf.production/log4j.properties",
      notify  => Service['hadoop-hdfs-namenode'];
  }
}
