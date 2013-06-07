class artifactory($jdk = "java-1.7.0-openjdk",
  $sourceforge = "http://downloads.sourceforge.net/project",
  $version = "3.0.1") {

# http://downloads.sourceforge.net/project/artifactory/artifactory/2.5.1.1/artifactory-2.5.1.1.rpm

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
    ensure    => 'running',
    enable => "true",
    hasstatus => "false",
    provider => "redhat",
    require => Package['artifactory'] 
  }

}
