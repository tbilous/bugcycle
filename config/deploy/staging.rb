# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

server '51.15.92.113', user: 'deploy', roles: %w{app db web}, primary: true
set :deploy_to, '/home/deploy/application/dating'
set :deploy_user, 'deploy'
set :rails_env, :staging
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :stage, :staging

# role-based syntax
# ==================
role :app, %w{deploy@51.15.92.113}
role :web, %w{deploy@51.15.92.113}
role :db, %w{deploy@51.15.92.113}

# Global options
# --------------
set :ssh_options, keys: %w(/home/btg/.ssh/id_rsa),
                  forward_agent: true,
                  auth_methods: %w(publickey password)
#
# The server-based syntax can be used to override options:
# ------------------------------------
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, 'unix:///home/deploy/application/dating/current/tmp/sockets/puma.sock'
set :puma_preload_app, true

set sidekiq_service_name: "sidekiq_#{fetch(:application)}_devbtg.info"

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts 'WARNING: HEAD is not the same as origin/master'
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  after :finishing,   :compile_assets
  after :finishing,   :cleanup
end
