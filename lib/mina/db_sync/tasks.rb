#require 'rake'
require 'yaml'
#require 'mina'
require 'mina/bundler'

namespace :db do
  desc "Puts given tables from the local db and exports to server db"
  task :put_tables do |t, table_names|
    run :local do
      set :local_run, true
      backup_tables(table_names)
      command %{scp dump.db.gz #{fetch(:user)}@#{fetch(:domain)}:#{fetch(:shared_path)}/dump.db.gz}
    end

    run :remote do
      set :local_run, false
      restore_tables
    end
  end

  desc "Gets given tables from the server and imports to the local db"
  task :get_tables do |t, table_names|
    run :remote do
      backup_tables(table_names)
    end

    run :local do
      set :local_run, true
      command %{scp #{fetch(:user)}@#{fetch(:domain)}:#{fetch(:shared_path)}/dump.db.gz .}
      restore_tables
    end
  end
end

def db_credentials(local: false)
  if fetch(:local_run)
    db = 'config/database.yml'
    db_type = 'development'
  else
    db = fetch(:shared_path) + '/config/database.yml'
    db_type = 'production'
  end

  %w(username password database).each do |val|
    command %{#{val.upcase}=$(ruby -ryaml -e 'puts YAML.load_file("#{db}")["#{db_type}"]["#{val}"]')}
  end
end

def backup_tables(table_names)
  db_credentials
  command %{pg_dump --format=c --no-owner #{tweak_tables(table_names)} $DATABASE > #{db_file}}
  command "gzip -f #{db_file}"
end

def restore_tables
  db_credentials
  command %{gunzip -f #{db_archive}}
  command %{pg_restore --no-owner --username=$USERNAME --clean --dbname=$DATABASE #{db_file}}
end

def db_archive
  return 'dump.db.gz' if fetch(:local_run)
  "#{fetch(:shared_path)}/dump.db.gz"
end

def db_file
  return 'dump.db' if fetch(:local_run)
  "#{fetch(:shared_path)}/dump.db"
end

def tweak_tables(table_names)
  if table_names.to_a.empty?
    STDOUT.write "Tables to get: "
    tables = STDIN.gets.strip
  else
    tables = table_names.to_a.join(' ')
  end

  tables.split(' ').map { |table| "--table=#{table}" }.join(' ')
end
