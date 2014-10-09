class beaker_platform::repo {
  yumrepo { "scl_ruby193":
    baseurl  => "https://www.softwarecollections.org/repos/rhscl/ruby193/epel-6-x86_64/",
    descr    => "Ruby 1.9.3 Dynamic Software Collection",
    enabled  => 1,
    gpgcheck => 0,
  }

  yumrepo { "v8314_epel":
    baseurl  => "https://www.softwarecollections.org/repos/rhscl/v8314/epel-6-x86_64/",
    descr    => "v8314 epel-6-x86_64",
    enabled  => 1,
    gpgcheck => 0,
    require  => Yumrepo['scl_ruby193'],
  }

  yumrepo { "rhscl_v8314_epel":
    baseurl  => "https://www.softwarecollections.org/repos/rhscl/v8314/rhscl-v8314-epel-6-x86_64/",
    descr    => "rhscl-v8314-epel-6-x86_64",
    enabled  => 1,
    gpgcheck => 0,
    require  => [Yumrepo['scl_ruby193'], Yumrepo['v8314_epel']],
  }

  exec { 'wget_oel_repo':
    command => "/usr/bin/wget http://public-yum.oracle.com/public-yum-ol6.repo -O /etc/yum.repos.d/public-yum-ol6.repo",
    creates => "/etc/yum.repos.d/public-yum-ol6.repo",
  }

  file { '/etc/yum.repos.d/public-yum-ol6.repo':
    mode    => 0644,
    require => Exec['wget_oel_repo'],
  }

  package { 'epel-release':
    ensure   => installed,
    source   => "https://anorien.csc.warwick.ac.uk/mirrors/epel/6/x86_64/epel-release-6-8.noarch.rpm",
    provider => rpm,
    require  => [Yumrepo['rhscl_v8314_epel'], Exec['wget_oel_repo'], Yumrepo['base']],
  }

  package { 'puppetlabs-release':
    ensure   => installed,
    source   => "https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm",
    provider => rpm,
    require  => Package['epel-release'],
  }
}