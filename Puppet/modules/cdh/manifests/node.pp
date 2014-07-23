# Node is the base node of the CDH hosts.
class cdh::node {
  class {
    'base':;
    'jdk':;
    'cdh::apt_repository':;
  }

  package {
    'hadoop':
      ensure  => installed,
      require => Class['cdh::apt_repository'];
  }
}
