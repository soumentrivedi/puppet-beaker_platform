class beaker_platform::setup_docker (
  $docker_tcp_connection = "$beaker_platform::params::docker_tcp_connection",
  $docker_socket         = "$beaker_platform::params::docker_socket",
  $docker_dns            = "$beaker_platform::params::docker_dns",
  $no_proxy              = undef,) inherits beaker_platform::params {
  $packages = ['docker-io']

  package { $packages:
    ensure  => installed,
    require => Package['puppetlabs-release'],
  }

  package { 'docker-api':
    ensure   => installed,
    require  => Package['docker-io'],
    provider => 'gem',
  }

  service { 'docker': ensure => running, }

  file { "docker_config":
    content => template('beaker_platform/docker.erb'),
    path    => '/etc/sysconfig/docker',
    ensure  => file,
    require => Package['docker-io'],
    notify  => Service['docker'],
  }
}