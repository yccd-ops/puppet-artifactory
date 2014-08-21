class artifactory::service inherits artifactory {

  if $::osfamily == 'Debian' {

    file { '/etc/init.d/artifactory':
      ensure  => present,
      content => template('artifactory/artifactory.Debian.init.erb'),
      owner   => root,
      group   => root,
      mode    => '0755'
    }
    -> service { 'artifactory':
      ensure   => 'running',
      provider => 'debian',
      enable   => true,
    }

  } elsif $::osfamily == 'RedHat' {

    service { 'artifactory':
      ensure    => 'running',
      enable    => true,
      hasstatus => false,
      provider  => 'redhat',
      require   => Package['artifactory']
    }
  }

}
