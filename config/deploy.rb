require "bundler/capistrano"
require "rvm/capistrano"
# require 'capistrano/ext/database'

#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"

set :application, "rqi" #matches names used in smf_template.erb
set :repository,  "https://github.com/ucsd-ra/reumanager.git"
set :branch, :rqi
set :domain, 'indra.ucsd.edu'
set :deploy_to, "/var/www/#{application}" # I like this location
set :deploy_via, :remote_cache
set :user, "ubuntu"
set :keep_releases, 6
set :rvm_ruby_string, "2.1.1@#{application}"
set :rvm_type, :system
set :server_name, domain
set :scm, :git
set :default_env, {
  "RAILS_RELATIVE_URL_ROOT" => "/rqi"
}

set :asset_env, "#{asset_env} RAILS_RELATIVE_URL_ROOT=/rqi"

default_run_options[:pty] = true

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "chown & chmod to www-data"
  task :chown do
    sudo "chown -R jjg:www-data #{deploy_to}"
    sudo "chmod -R 775 #{deploy_to}"
  end

  desc "Add config dir to shared folder"
  task :add_shared_config do
    run "mkdir #{deploy_to}/shared/config"
  end

  desc "Symlink configs"
  task :symlink_configs, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/*.yml #{release_path}/config/"
  end
end

namespace :ckeditor do
  desc "Symlink the Rack::Cache files"
  task :symlink, :roles => [:app] do
    run "mkdir -p #{shared_path}/system/ckeditor_assets && ln -nfs #{shared_path}/system/ckeditor_assets #{release_path}/system/ckeditor_assets"
  end
end
# after 'deploy:update_code', 'ckeditor:symlink'

before 'deploy:assets:precompile', 'deploy:symlink_configs'
after 'deploy:setup', 'deploy:add_shared_config'
