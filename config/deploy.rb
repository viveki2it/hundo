require "rvm/capistrano"

load 'deploy/assets'

set :rvm_ruby_string, '1.9.2'

require 'bundler/capistrano'

set :application, "mobile_site"

set :env, "production"
set :rails_env, "production"

set :base_path, "/home/www/sites/rails/#{application}"
set :app_path, "#{base_path}/current"

set :scm, :git
set :repository,  "git@github.com:mapiech/mobile-site.git"
set :branch, "master"
set :deploy_via, :copy
set :git_shallow_clone, 1
set :deploy_to, "#{base_path}"

set :keep_releases, 1

role :app, "direct.marek-piechocki.pl"
role :web, "direct.marek-piechocki.pl"
role :db,  "direct.marek-piechocki.pl", :primary => true

set :user, "www"

set :use_sudo, false

after "deploy:update_code","deploy:config_symlink"

namespace :deploy do

  desc "Copy database.yml"
  task :config_symlink do
    run "cp -f #{shared_path}/database.yml #{release_path}/config/database.yml"
  end

  desc "Restarting app with restart.txt"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end


after "deploy", "deploy:cleanup"

