class beaker_platform::setup {
  require beaker_platform::repo
  require beaker_platform::setup_beaker
  require beaker_platform::setup_docker
  require beaker_platform::setup_gitreview
}