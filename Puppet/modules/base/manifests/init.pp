# base class for all the hosts
class base {

  include 'avahi'

  # SSH Keys for password-less access to the hosts
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
