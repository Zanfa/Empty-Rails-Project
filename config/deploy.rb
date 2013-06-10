require 'bundler/capistrano'

set :application, "my_app"
set :repository,  "git://github.com/Zanfa/Empty-Rails-Project.git"

set :branch, "master"
set :deploy_to, "/home/deployer/app"
set :user, "deployer"
set :use_sudo, false

ssh_options[:keys] = ["~/.ssh/chef.pem"]

server "ec2-54-228-148-206.eu-west-1.compute.amazonaws.com", :app, :web, :db, :primary => true

desc "Zero-downtime restart of Unicorn"
task :restart, :except => { :no_release => true } do
  run "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
end

desc "Start unicorn"
task :start, :except => { :no_release => true } do
  run "cd #{current_path} ; bundle exec unicorn_rails -c /etc/unicorn/app.rb -D -E production"
end

desc "Stop unicorn"
task :stop, :except => { :no_release => true } do
  run "kill -s QUIT `cat #{shared_path}/pids/unicorn.pid`"
end

after "deploy", "restart"
before "deploy", "deploy:setup"