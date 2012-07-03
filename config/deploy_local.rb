set :application, "192.168.0.247"
set :repository, "git://github.com/alexsoares/con_pon.git"
set :user, "administrador"
set :use_sudo, false
set :deploy_to, "/home/#{user}/consulta_pon"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server application, :app, :web, :db, :primary => true
after "deploy:update_code", "deploy:custom_symlinks"
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end

   task :custom_symlinks do
     run "rm -rf #{release_path}/config/database.yml"
     run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
   end
 end
