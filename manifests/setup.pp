class beaker_platform::setup {
  require platform_repos
  require beaker_platform::setup_beaker
  require beaker_platform::setup_docker
  require beaker_platform::setup_gitreview
}