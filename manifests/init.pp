class artifactory($jdk = "java-1.6.0-openjdk",
  $sourceforge_mirror = "http://cdnetworks-us-2.dl.sourceforge.net/project",
  $version = "2.3.4.1") {

  # wget from https://github.com/maestrodev/puppet-wget
  include wget

  if ! defined (Package[$jdk]) {
    package { $jdk: ensure => installed }
  }

  package { 'artifactory':
    ensure => installed,
    provider => "rpm",
    source => "$sourceforge_mirror/artifactory/artifactory/$version/artifactory-$version.rpm",
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