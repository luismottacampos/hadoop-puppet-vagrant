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
    'localhost.localdomain':
      ensure       => present,
      host_aliases => 'localhost',
      ip           => '127.0.0.1';
    'elephant.lmc.dev':
      ensure       => present,
      host_aliases => 'elephant',
      ip           => '192.168.1.2';
    'tiger.lmc.dev':
      ensure       => present,
      host_aliases => 'tiger',
      ip           => '192.168.1.3';
    'horse.lmc.dev':
      ensure       => present,
      host_aliases => 'horse',
      ip           => '192.168.1.4';
    'monkey.lmc.dev':
      ensure       => present,
      host_aliases => 'monkey',
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

