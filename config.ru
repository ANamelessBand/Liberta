Dir.glob('./{models,helpers}/*.rb').each { |file| require file }
require './controllers/application_controller'

$:.unshift(File.expand_path('../lib', __FILE__))

Dir.glob('./controllers/*.rb').each { |file| require file }

map('/profile') { run ProfileController }
map('/') { run WebsiteController }