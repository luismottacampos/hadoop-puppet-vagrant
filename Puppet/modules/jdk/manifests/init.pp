# class jdk - installs Oracle JDK 1.7.0_65 from Oracle's tarball.
class jdk {

  # TODO: parametrise the java deployment dir
  # TODO: parametrise the java tarball location
  # TODO: register the java binaries with the alternatives system

  file {
    '/var/lib/java':
      ensure => directory,
      mode   => '0755',
      owner  => 'root',
      group  => 'root';
  }

  # Deploy Java from tarball
  exec { 'unpack-oracle-jdk':
    command => 'tar xzCf /var/lib/java /vagrant/Repository/jdk-7u65-linux-x64.tar.gz',
    path    => ['/bin', '/usr/bin'],
    require => File['/var/lib/java'],
    onlyif  => '/usr/bin/test \'! -d /var/lib/java/jdk1.7.0_65\''
  }
}
