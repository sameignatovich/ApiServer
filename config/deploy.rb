# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "ApiServer"
set :repo_url, "git@github.com:sameignatovich/ApiServer.git"
set :branch, "main"
set :rails_env, "production"
set :deploy_to, "/home/nginx/www/api.big.wtf"

set :format, :airbrussh
set :format_options, truncate: false

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", ".bundle", "storage"
set :keep_releases, 5

set :rvm_custom_path, "/usr/share/rvm"

set :sidekiq_roles, :app
set :sidekiq_default_hooks, true
set :sidekiq_pid, File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid')
set :sidekiq_env, "production"
set :sidekiq_log, File.join(shared_path, 'log', 'sidekiq.log')
set :sidekiq_config, 'config/sidekiq.yml'
set :sidekiq_processes, 1 # number of systemd processes you want to start
set :sidekiq_service_templates_path, 'config/deploy/templates'
set :sidekiq_service_unit_name, 'sidekiq'
set :sidekiq_service_unit_user, :user # :system
set :sidekiq_enable_lingering, true
set :sidekiq_lingering_user, nil
set :sidekiq_user, nil #user to run sidekiq as

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key_file do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! "config/master.key", "#{shared_path}/config/master.key"
        end
      end
    end
  end

  # before :finishing, :restart_sidekiq do
  #   on roles(:app) do
  #     execute "sudo systemctl restart sidekiq.service"
  #   end
  # end
end
