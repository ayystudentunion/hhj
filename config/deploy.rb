require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.3'        # Or whatever env you want it to run in.
set :rvm_type, :user

require "bundler/capistrano"

set :application, "halloped"
set :repository,  "git@github.com:ayy/hhj.git"
set :user, "leonidas"

set :deploy_to, "/home/#{user}/#{application}"
set :use_sudo, false

ssh_options[:forward_agent] = true

set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :scm_verbose, true

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "halloped.fi"                          # Your HTTP server, Apache/etc
role :app, "halloped.fi"                          # This may be the same as your `Web` server
role :db,  "halloped.fi", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

