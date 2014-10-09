# This class exists solely to aggregate the set of information that tie
# together the Beaker Platform.
#
class beaker_platform::params (
  $docker_tcp_connection = "tcp://0.0.0.0:4243",
  $docker_socket         = "unix:///var/run/docker.sock",
  $docker_dns            = ['10.160.148.11'],) {
  # No resources are declared by this class. It should only be used to set
  # Hiera parameters to propagate to inheriting classes.
}
