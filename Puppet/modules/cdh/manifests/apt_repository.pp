# Deploy APT repositories as required
class cdh::apt_repository {
  include '::apt'

  # TODO: convert this to use the local file-based mirror and see if you can improve performance.

  apt::key{ 'cloudera':
    key        => '02A818DD',
    key_source => 'http://archive-primary.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/archive.key',
  }

  apt::source { 'cloudera_cdh5':
      location => '[arch=amd64] http://archive-primary.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/',
      release  => 'precise-cdh5.1.0',
      repos    => 'contrib',
      key      => '02A818DD',
  }

  exec { 'apt-update':
    command => '/usr/bin/apt-get update',
    require => Apt::Source['cloudera_cdh5'],
  }
}
