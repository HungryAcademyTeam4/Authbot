require 'bundler/capistrano'

server "50.116.38.51", :web, :db, :app, primary: true
set :user, "deployer"
set :application, "Authbot"

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache


set :scm, "git"
set :repository,  "git@github.com:HungryAcademyTeam4/Authbot.git"
set :branch, "testdeploy"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  desc "Start the Thin processes"
  task :bundle_install do
    run "cd /home/#{user}/apps/#{application}/current && bundle install"
  end
  task :start do
    bundle_install
    run "cd /home/#{user}/apps/#{application}/current && bundle exec rake db:migrate"
    run "cd /home/#{user}/apps/#{application}/current && bundle exec ruby ./authbot.rb -p 4568"
  end
end