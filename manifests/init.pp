class artifactory(
  $jdk = 'java-1.8.0-openjdk',
  $bintray = 'https://bintray.com/artifact/download/jfrog/artifactory-rpms/',
  $version = '4.2.2') {

  # https://bintray.com/artifact/download/jfrog/artifactory-rpms/jfrog-artifactory-oss-4.2.2.rpm

  if ! defined (Package[$jdk]) {
    package { $jdk: ensure => installed }
  }

  package { 'artifactory':
    ensure   => installed,
    provider => 'rpm',
    source   => "${bintray}/jfrog-artifactory-oss-${version}.rpm",
    require  => Package[$jdk]
  }

  service { 'artifactory':
    ensure    => 'running',
    enable    => true,
    hasstatus => false,
    provider  => 'redhat',
    require   => Package['artifactory']
  }

}
