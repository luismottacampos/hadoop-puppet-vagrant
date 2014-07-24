# Builds a mirror server for CDH
class apt_mirror {
  include '::ntp'

  package {
    'apt-mirror':
      ensure => installed;
  }

  file {
    '/vagrant/Repository':
      ensure => directory;
    '/vagrant/Repository/mirror':
      ensure => directory;
    '/vagrant/Repository/skel':
      ensure => directory;
    '/vagrant/Repository/var':
      ensure => directory;
    '/etc/apt/mirror.list':
      ensure  => present,
      owner   => 'root',
      mode    => '0644',
      require => Package['apt-mirror'],
      source  => "puppet:///modules/${module_name}/etc/apt/mirror.list",
  }

}
