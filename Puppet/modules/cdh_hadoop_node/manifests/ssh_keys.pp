# Class cdh_hadoop_node::ssh_keys - distribute user ssh keys
class cdh_hadoop_node::ssh_keys {
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
      source => "puppet:///modules/${module_name}/home/vagrant/dot-ssh/cdh-key.pub";
    '/home/vagrant/.ssh/config':
      ensure => present,
      mode   => '0644',
      owner  => 'vagrant',
      source => "puppet:///modules/${module_name}/home/vagrant/dot-ssh/config";
  }
}
