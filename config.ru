require 'sinatra/base'
require 'sinatra/reloader'

$:.unshift(File.expand_path('../../lib', __FILE__))

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

map('/example') { run ExampleController }
map('/') { run WebsiteController }