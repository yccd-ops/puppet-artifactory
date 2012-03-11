class artifactory($jdk = "java-1.6.0-openjdk",
  $sourceforge_mirror = "http://downloads.sourceforge.net/project",
  $version = "2.5.1.1") {

# http://downloads.sourceforge.net/project/artifactory/artifactory/2.5.1.1/artifactory-2.5.1.1.rpm?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fartifactory%2Ffiles%2Fartifactory%2F2.5.1.1%2Fartifactory-2.5.1.1.rpm%2Fdownload&ts=1331429681&use_mirror=voxel

  # wget from https://github.com/maestrodev/puppet-wget
  include wget

  if ! defined (Package[$jdk]) {
    package { $jdk: ensure => installed }
  }

  package { 'artifactory':
    ensure => installed,
    provider => "rpm",
    source => "$sourceforge/artifactory/artifactory/$version/artifactory-$version.rpm",
    require => Package[$jdk]
  }

  service { 'artifactory':
    ensure => "true",
    enable => "true",
    hasstatus => "false",
    provider => "redhat",
    require => Package['artifactory'] 
  }

}