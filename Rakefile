require 'sequel'
require 'yaml'

# Load config file
settings = YAML::load(File.open('config.yml'))

namespace :db do
  Sequel.extension :migration, :core_extensions

  migrator    = Sequel::Migrator
  migrations  = settings['migrations_path']
  environment = settings['environment']
  env_settngs = settings[environment]

  # Setup Database Connection
  case environment
  when 'development'
    sqlite_path = env_settngs['sqlite_path']
    DB = Sequel.sqlite(sqlite_path)

  when 'production'
    db_host     = env_settngs['db_host']
    db_name     = env_settngs['db_name']
    db_user     = env_settngs['db_user']
    db_password = env_settngs['db_password']

    DB = Sequel.postgres(db_name, host: db_host, user: db_user, password: db_password)
  end

  task :drop do
    puts "Reverting all migrations..."
    migrator.apply(DB, migrations, 0)
    puts "Done!"
  end

  task :migrate do
    puts "Migrating to newest migration..."
    migrator.apply(DB, migrations)
    puts "Done!"
  end

  task :reset do
    Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
  end

  task :fake do
    puts "Populating database with presentation-ready data..."
    require './database/dummy_data_presentation.rb'
    puts "Done!"
  end

  task :dummy do
    puts "Populating database with dummy data..."
    require './database/dummy_data_population.rb'
    puts "Done!"
  end

  task :help do
    puts "Run with rake db:command. Available commands:"
    puts "drop    - Reverts all migrations"
    puts "reset   - Reverts all migrations and applies all again"
    puts "migrate - Migrates to newest migration"
    puts "dummy   - Fills the database with dummy data"
    puts "fake    - Fills the database with presentation-ready dummy data"
    puts "help    - Prints this help message"
  end

end


