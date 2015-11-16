class artifactory(
  $jdk = 'java-1.8.0-openjdk',
  $bintray = 'https://bintray.com/artifact/download/jfrog/artifactory/',
  $version = '4.2.2') {

  # https://bintray.com/artifact/download/jfrog/artifactory/jfrog-artifactory-oss-4.2.2.zip

  if ! defined (Package[$jdk]) {
    package { $jdk: ensure => installed }
  }

  package { 'artifactory':
    ensure   => installed,
    provider => 'rpm',
    source   => "${bintray}/jfrog-artifactory-oss-${version}.zip",
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
