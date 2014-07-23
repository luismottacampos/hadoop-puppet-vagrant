# class jdk - installs Oracle JDK 1.7.0_65 from Oracle's tarball.
class jdk (
  $java_home = '/usr/java',
  $java_tarball = '/vagrant/Repository/jdk-7u65-linux-x64.tar.gz'
) {

  # TODO: register the java binaries with the alternatives system?
  # TODO: Add the java binaries to the path using the "/etc/profile.d/" directory?

  file {
    $java_home:
      ensure => directory,
      mode   => '0755',
      owner  => 'root',
      group  => 'root';
  }

  # Deploy Java from tarball
  exec { 'unpack-oracle-jdk':
    command => "tar xzCf ${java_home} ${java_tarball}",
    path    => ['/bin', '/usr/bin'],
    require => File[$java_home],
    onlyif  => "/usr/bin/test '! -d ${java_home}/jdk1.7.0_65'"
  }
}
