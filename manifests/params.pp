# == Class Artifactory::Params
# Contains all the parameters for the Artifactory module
class artifactory::params {
  $username     = 'artifactory'
  $pass_hash    = undef
  $manage_java  = false
  $java_version = '7'
  $app_dir      = '/opt/artifactory'
  $app_data     = '/var/artifactory'
  $app_version  = '3.3.0'
}
