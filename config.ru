require 'rubygems'
require 'date'
require 'bundler/setup'

Bundler.require :default

#==============================================================================
# Setup environments
#==============================================================================

class Sinatra::Base
  register Sinatra::ConfigFile
  config_file 'config.yml'

  set :environment, settings.environment

  set :views,         File.expand_path(settings.views_path,  __FILE__)
  set :public_folder, File.expand_path(settings.public_path, __FILE__)

  enable :sessions

  # call Bundle.require for each environment
  settings.environments.each do |environment|
    configure environment do
      Bundler.require environment
    end
  end

  configure :development do
    register Sinatra::Reloader

    DB = Sequel.sqlite settings.development[:sqlite_path]
  end

  configure :production do
    disable :show_exceptions

    db_host     = settings.production['db_host']
    db_name     = settings.production['db_name']
    db_user     = settings.production['db_user']
    db_password = settings.production['db_password']

    DB = Sequel.postgres(db_name, host: db_host, user: db_user, password: db_password)
  end

  DB.extension(:pagination)
end


#==============================================================================
# Require all custom constants, models, controllers and helpers
#==============================================================================

require './constants.rb'

require_file = -> (file) { require file }
Dir.glob('./{models,helpers}/**/*.rb').each &require_file

require './controllers/application_controller'
Dir.glob('./controllers/**/*.rb').each &require_file


#==============================================================================
# Map Top Level Controllers
#==============================================================================

controllers = [WebsiteController, PrintsController,
               UsersController, AdministrationController]

controllers.each do |controller|
  map (controller::NAMESPACE) { run controller }
end
