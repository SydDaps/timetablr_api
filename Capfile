require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'figaro'

set :rvm_type, :user
set :rvm_ruby_version, '3.0.1'

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/bundler'
require 'capistrano/rails/migrations'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }