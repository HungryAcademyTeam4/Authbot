MODE = "staging"
PRODUCTION_SERVER = "fallingfoundry.com"
STAGING_SERVER = "fallinggarden.com"
SERVER = MODE == "production" ? PRODUCTION_SERVER : STAGING_SERVER


$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
 require 'bundler/capistrano'
 require 'rvm/capistrano'
server SERVER, :web, :db, :app, primary: true
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

# set :unicorn_binary, "/usr/bin/unicorn"
# set :unicorn_config, "#{shared_path}/config/unicorn.rb"
# set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"



namespace :deploy do
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
    run "cd /home/#{user}/apps/#{application}/current && RAILS_ENV=production bundle install"
    run "cd /home/#{user}/apps/#{application}/current && RAILS_ENV=production bundle exec rake db:create && bundle exec rake db:migrate"
    run "cd /home/#{user}/apps/#{application}/current && RAILS_ENV=production bundle exec unicorn -p 4568 -D"
  end
  after "deploy", "deploy:create_release_log"
  after "deploy", "deploy:start"

  # # task :start, :roles => :app, :except => { :no_release => true } do 
  # #   run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  # # end
  # task :stop, :roles => :app, :except => { :no_release => true } do 
  #   run "#{try_sudo} kill `cat #{unicorn_pid}`"
  # end
  # task :graceful_stop, :roles => :app, :except => { :no_release => true } do
  #   run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  # end
  # task :reload, :roles => :app, :except => { :no_release => true } do
  #   run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  # end
  # task :restart, :roles => :app, :except => { :no_release => true } do
  #   stop
  #   start
  # end

end