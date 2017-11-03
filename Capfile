# Load DSL and set up stages
require 'capistrano/setup'
# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git
require 'capistrano/rbenv'
require 'capistrano/rbenv_install'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
install_plugin Capistrano::Puma
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
