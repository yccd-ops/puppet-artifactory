class artifactory::user inherits artifactory {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  user { $artifactory::username:
    ensure      => present,
    managehome  => true,
    home        => $artifactory::app_data,
    password    => $artifactory::pass_hash
  }
}
