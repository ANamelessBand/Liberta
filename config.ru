require 'date'
require 'rubygems'
require 'sequel'
require 'sinatra/base'
require 'sinatra/reloader'

require './constants.rb'

#==============================================================================
# Setup environments
#==============================================================================

class Sinatra::Base
  set :environment, :development

  set :views,         File.expand_path('../views',  __FILE__)
  set :public_folder, File.expand_path('../public', __FILE__)

  enable :sessions

  configure :development do
    Sequel.sqlite("database/liberta.db")
    register Sinatra::Reloader
  end

  configure :production do
    Sequel.sqlite("database/liberta.db")
    disable :show_exceptions
  end
end


#==============================================================================
# Require all models, controllers and helpers
#==============================================================================

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
