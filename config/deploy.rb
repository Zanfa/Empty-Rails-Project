require 'bundler/capistrano'

set :application, "my_app"
set :repository,  "git://github.com/Zanfa/Empty-Rails-Project.git"

set :branch, "master"
set :deploy_to, "/home/deployer/app"
set :user, "deployer"
set :use_sudo, false

ssh_options[:keys] = ["~/.ssh/chef.pem"]

server "ec2-54-228-148-206.eu-west-1.compute.amazonaws.com", :app, :web, :db, :primary => true

before "deploy", "deploy:setup"