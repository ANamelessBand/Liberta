require 'sequel'
require 'date'


puts "Deleting database..."
system 'rm ./database/liberta.db'
puts "done"

puts "Creating database"
system 'sequel -m ./database/migrations sqlite://./database/liberta.db'
puts "done"

# Sequel.sqlite('./database/liberta.db')

Sequel.postgres('liberta', :host=>'localhost', :user=>'liberta', :password=>'liberta')

Dir.glob('./models/sequel/*.rb').each { |file| require file }

require './database/presentation_dummy_data/dummy_data'
