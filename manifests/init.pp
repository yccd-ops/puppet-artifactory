class artifactory (
  $username     = $artifactory::params::username,
  $pass_hash    = $artifactory::params::pass_hash,
  $manage_java  = $artifactory::params::manage_java,
  $java_version = $artifactory::params::java_version,
  $app_dir      = $artifactory::params::app_dir,
  $app_data     = $artifactory::params::app_data,
  $app_version  = $artifactory::params::app_version

) inherits artifactory::params {
  anchor { '::artifactory::start': } ->
    class { '::artifactory::user': } ->
    class { '::artifactory::install': } ->
    class { '::artifactory::service': } ->
  anchor { '::artifactory::end': }
}
