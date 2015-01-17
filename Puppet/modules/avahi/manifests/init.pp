# Installs avahi
class avahi{

  exec { 'avahi-apt-update':
    command => '/usr/bin/apt-get update',
  }

  package {
    'avahi-daemon':
      ensure  => 'installed',
      require => Exec['avahi-apt-update'];
  }

  # /etc/hosts configuration
  host {
    'localhost':
      ensure       => present,
      host_aliases => 'localhost.localdomain',
      ip           => '127.0.0.1';
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

  service{
    'avahi-daemon':
      ensure  => 'running',
      enable  => true,
      require =>  File['/etc/avahi/avahi-daemon.conf'];
  }

  file{
    '/etc/avahi/avahi-daemon.conf':
      source  => 'puppet:///modules/avahi/avahi-daemon.conf',
      owner   => root,
      group   => root,
      notify  => Service['avahi-daemon'],
      require => Package['avahi-daemon'];
    '/etc/avahi/hosts':
      ensure => link,
      target => '/etc/hosts',
      owner  => root,
      group  => root;
  }
}

