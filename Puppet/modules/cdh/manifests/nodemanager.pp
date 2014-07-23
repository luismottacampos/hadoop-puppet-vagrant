# Class nodemanager - installs a node manager
class cdh::nodemanager {
  package {
    'hadoop':
      ensure => installed;
    'hadoop-yarn-nodemanager':
      ensure => installed;
}
