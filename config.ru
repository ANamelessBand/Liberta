require 'date'
require 'rubygems'
require 'sequel'
require 'sinatra/base'
require 'sinatra/reloader'

SEARCH_RESULT_BY_PAGE = 5

Sequel.sqlite("database/liberta.db")

Dir.glob('./{models,helpers}/**/*.rb').each { |file| require file }
require './controllers/application_controller'

$:.unshift(File.expand_path('../lib', __FILE__))

Dir.glob('./controllers/**/*.rb').each { |file| require file }

map('/prints') { run PrintsController }
map('/users') { run UsersController }
map('/') { run WebsiteController }
