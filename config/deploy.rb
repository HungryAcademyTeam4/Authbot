$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
 require 'bundler/capistrano'
 require 'rvm/capistrano'
server "fallinggarden.com", :web, :db, :app, primary: true
set :user, "deployer"
set :application, "Authbot"

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, true

set :scm, "git"
set :repository,  "git://github.com/HungryAcademyTeam4/Authbot.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true



namespace :deploy do
  desc "Start the Thin processes"
  task :bundle_install do
    run "cd /home/#{user}/apps/#{application}/current && bundle install"
  end
  task :create_release_log do
    run <<-CMD
    rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids &&
    mkdir -p #{latest_release}/public &&
    mkdir -p #{latest_release}/tmp &&
    ln -s #{shared_path}/log #{latest_release}/log &&
    ln -s #{shared_path}/system #{latest_release}/public/system &&
    ln -s #{shared_path}/pids #{latest_release}/tmp/pids
    CMD
  end
  task :start do
    bundle_install
    create_release_log
    run "cd /home/#{user}/apps/#{application}/current && bundle exec rake db:create && bundle exec rake db:migrate"
    run "cd /home/#{user}/apps/#{application}/current && bundle exec rails s -p 4568 -e production"
  end
end