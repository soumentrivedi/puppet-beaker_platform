class beaker_platform::setup_gitreview {
  $packages = ['git-review']

  package { $packages:
    ensure  => installed,
    require => Package['puppetlabs-release'],
  }
}