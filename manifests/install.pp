class artifactory::install inherits artifactory {

  if $::osfamily == 'Debian' {

    $url = "http://dl.bintray.com/jfrog/artifactory/artifactory-${artifactory::app_version}.zip"
    $artifactory::extracted = "${artifactory::app_dir}/artifactory-${artifactory::app_version}"

    if $caller_module_name != $module_name {
      fail("Use of private class ${name} by ${caller_module_name}")
    }

    file { $artifactory::app_data:
      ensure => directory,
      mode   => '0755',
      owner  => $artifactory::username,
      group  => $artifactory::username
    }
    -> file { $artifactory::app_dir:
      ensure => directory,
      mode   => '0755',
      owner  => $artifactory::username,
      group  => $artifactory::username
    }
    -> staging::deploy { "artifactory-${artifactory::app_version}.zip":
      source  => $url,
      creates => $artifactory::extracted,
      target  => $artifactory::app_dir,
      user    => $artifactory::username,
      group   => $artifactory::username
    }
    -> file { "${artifactory::app_dir}/current":
      ensure => link,
      target => $artifactory::extracted
    }
    -> file { "${artifactory::app_dir}/current/data":
      ensure => link,
      target => $artifactory::app_data
    }

  } elsif $::osfamily == 'RedHat' {
    package { 'artifactory':
      ensure   => installed,
      provider => 'rpm',
      source   => "http://downloads.sourceforge.net/project/artifactory/artifactory/${artifactory::app_version}/artifactory-${artifactory::app_version}.rpm",
    }
  }

}
