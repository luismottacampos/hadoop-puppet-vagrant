node /^.+\.lmc\.dev$/ {
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

  package { 'hadoop-conf-pseudo': ensure => installed }

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
}
