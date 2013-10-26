require 'rubygems'
require 'sequel'
require 'sinatra/base'
require 'sinatra/reloader'

class ApplicationController < Sinatra::Base
  attr_accessor :navigation_links

  helpers ApplicationHelpers
  
  configure :development do
    register Sinatra::Reloader
  end

  configure :production do
    disable :show_exceptions
  end
 
  set :views, File.expand_path('../../views', __FILE__)
  enable :sessions, :method_override

  not_found { erb :'not_found.html' }
end