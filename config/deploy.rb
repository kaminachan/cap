# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "cap"
set :keep_releases, 1
set :use_sudo, false
set :repo_url, "git@github.com:kaminachan/cap.git"
set :deploy_to, "/home/#{fetch(:application)}"
set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')
set :rvm_type, :system
set :rvm_ruby_version, '2.6.3@cap'
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
