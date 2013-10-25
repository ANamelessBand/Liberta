$:.unshift(File.expand_path('../../lib', __FILE__))

require 'sinatra/base'
require 'rubygems'
require 'sequel'
require 'sinatra/base'
require 'sinatra/reloader'

class ApplicationController < Sinatra::Base

  helpers ApplicationHelpers
 
  set :views, File.expand_path('../../views', __FILE__)

  not_found{ erb :'not_found.html' }
end