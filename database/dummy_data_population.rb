require 'sequel'
require 'date'

Sequel.sqlite('./liberta.db')


Dir.glob('./../models/sequel/*.rb').each { |file| require file }

tables = [
                'authors',
                'tags',
                'formats',
                'users',
                'notifications',
                'publishers',
                'prints',
                'recommendations',
                'wishlists'
               ]

tables.each do |table|
  puts "Populating dummy data into #{table}..."
  require "./dummy_data_packs/dummy_#{table}.rb"
  puts "done"
end
