require 'bundler/capistrano'

server "50.116.60.38", :web, :db, :app, primary: true
set :user, "root"
set :application, "Authbot"

set :deploy_to, "/home/apps/#{application}"
set :deploy_via, :remote_cache


set :scm, "git"
set :repository,  "git@github.com:HungryAcademyTeam4/Authbot.git"
set :branch, "master"

default_run_options[:pty] = true

namespace :deploy do
  desc "Start the Thin processes"
  task :bundle_install do
    run "cd /home/apps/#{application}/current && bundle install"
  end
  task :start do
    bundle_install
    run "cd /home/apps/#{application}/current && bundle exec rake db:migrate"
    run "cd /home/apps/#{application}/current && bundle exec ruby ./authbot.rb -p 4568"
  end
end