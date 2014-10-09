class beaker_platform::setup_beaker {
  $packages = ['ruby-devel', 'libxml2-devel', 'libxslt-devel', 'gcc-c++', 'libicu-devel']
  $beaker_path = '/tmp/beaker'
  $beaker_rspec_path = '/tmp/beaker-rspec'

  package { $packages:
    ensure  => installed,
    require => Package['puppetlabs-release'],
  } ->
  vcsrepo { $beaker_path:
    ensure   => present,
    provider => git,
    source   => "https://github.com/puppetlabs/beaker.git",
  }
  exec { 'bundle_install_beaker':
    cwd     => "$beaker_path",
    command => '/usr/bin/bundle install > .bundle.log',
    creates => "$beaker_path/.bundle.log",
    require => Vcsrepo["$beaker_path"],
    timeout => 0,
  } ->
  vcsrepo { $beaker_rspec_path:
    ensure   => present,
    provider => git,
    source   => "https://github.com/puppetlabs/beaker-rspec",
  }

  exec { 'bundle_install_beaker_rspec':
    cwd     => "$beaker_rspec_path",
    command => '/usr/bin/bundle install > .bundle.log',
    creates => "$beaker_rspec_path/.bundle.log",
    require => Vcsrepo["$beaker_rspec_path"],
    timeout => 0,
  }
}