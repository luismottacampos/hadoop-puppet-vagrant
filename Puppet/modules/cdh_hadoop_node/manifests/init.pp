# The main class for CDH Nodes governed by Puppet
class cdh_hadoop_node {

  include '::ntp'
  include '::apt'

  apt::key{ 'cloudera':
    key        => '02A818DD',
    key_source => 'http://archive-primary.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/archive.key',
  }

  apt::source { 'cloudera_cdh5':
      location => 'http://archive-primary.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/',
      release  => 'precise-cdh5.1.0',
      repos    => 'contrib',
      key      => '02A818DD',
  }

  package {
    # FIXME: unfold this list into the actual packages being installed
    'hadoop-conf-pseudo':
      ensure => installed;
    'flume-ng':
      ensure => installed;
  }

  # Host entries for /etc/hosts
  host {'elephant':
    ensure       => present,
    host_aliases => 'elephant.lmc.dev',
    ip           => '192.168.1.2'
  }

  host {'tiger':
    ensure       => present,
    host_aliases => 'tiger.lmc.dev',
    ip           => '192.168.1.3'
  }

  host {'horse':
    ensure       => present,
    host_aliases => 'horse.lmc.dev',
    ip           => '192.168.1.4'
  }

  host {'monkey':
    ensure       => present,
    host_aliases => 'monkey.lmc.dev',
    ip           => '192.168.1.5'
  }

  # deploy our ssh keys and ssh configuration
  file {
    '/home/vagrant/.ssh':
      ensure => directory,
      mode   => '0755',
      owner  => 'vagrant';
    '/home/vagrant/.ssh/cdh-key':
      ensure => present,
      mode   => '0600',
      owner  => 'vagrant',
      source => "puppet:///modules/${module_name}/home/vagrant/dot-ssh/cdh-key";
    '/home/vagrant/.ssh/cdh-key.pub':
      ensure => present,
      mode   => '0644',
      owner  => 'vagrant',
      source => "puppet:///modules/${module_name}/home/vagrant/dot-ssh/cdh-key.put";
    '/home/vagrant/.ssh/config':
      ensure => present,
      mode   => '0644',
      owner  => 'vagrant',
      source => "puppet:///modules/${module_name}/home/vagrant/dot-ssh/config";
  }

}
