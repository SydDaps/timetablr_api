# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "timetablr_api"
set :repo_url, "git@github.com:SydDaps/timetablr_api.git"

set :deploy_to, '/home/compeng/timetablr/backend'
set :branch, ENV['BRANCH'] if ENV['BRANCH']

set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 3
set :keep_assets, 3

set :db_local_clean, true
set :db_remote_clean, true

set :default_env, {
  TIMETABLR_API_DB_USERNAME: "postgres",
  TIMETABLR_API_DB_PASSWORD: "password",
  TIMETABLR_API_SECRETE: "hdfjhgfghvfofngb",
  GMAIL_USERNAME: "timetablr1@gmail.com",
  GMAIL_PASSWORD: "ditpmhtpkyfqioye",
  APIKEY: "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",
  DB_HOST: "localhost",
  REDIS_URL: "redis://127.0.0.1:6379/1"
}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

namespace :debug do
  desc 'Print ENV variables'
  task :env do
    on roles(:app), in: :sequence, wait: 5 do
      execute :printenv
    end
  end
end