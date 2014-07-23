# base class for all the hosts
class base {

  # /etc/hosts configuration
  host {
    'elephant':
      ensure       => present,
      host_aliases => 'elephant.lmc.dev',
      ip           => '192.168.1.2';
    'tiger':
      ensure       => present,
      host_aliases => 'tiger.lmc.dev',
      ip           => '192.168.1.3';
    'horse':
      ensure       => present,
      host_aliases => 'horse.lmc.dev',
      ip           => '192.168.1.4';
    'monkey':
      ensure       => present,
      host_aliases => 'monkey.lmc.dev',
      ip           => '192.168.1.5';
  }

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
