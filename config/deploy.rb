# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'ta70-back'
set :repo_url, 'git@github.com:aurelienblais/ta70-back.git'

set :deploy_to, '/home/naritaya/ta70-back'

append :linked_files, '.env'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :rvm_custom_path, '/home/naritaya/.rvm/'
set :rvm_ruby_version, '2.5.3'
