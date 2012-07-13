set :application, "test.pontuacao.seducpma.com"
set :repository,  "git://github.com/alexsoares/pontuacao_atual.git"
set :user, "servidor"
set :use_sudo, false
set :deploy_to, "/home/#{user}/#{application}"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
server application, :app, :web, :db, :primary => true

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
