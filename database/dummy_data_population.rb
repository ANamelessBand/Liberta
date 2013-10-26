require 'sequel'
require 'date'


puts "Deleting database..."
system 'rm ./database/liberta.db'
puts "done"

puts "Creating database"
system 'sequel -m ./database/migrations sqlite://./database/liberta.db'
puts "done"

Sequel.sqlite('./database/liberta.db')


Dir.glob('./models/sequel/*.rb').each { |file| require file }

tables = [
          'authors',
          'tags',
          'formats',
          'users',
          'notifications',
          'publishers',
          'prints',
          'recommendations',
          'wishlists',
          'copies',
          'loans',
         ]

tables.each do |table|
  puts "Populating dummy data into #{table}..."
  require "./database/dummy_data_packs/dummy_#{table}.rb"
  puts "done"
end
