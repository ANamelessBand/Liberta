require 'date'

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
          'news',
         ]

tables.each do |table|
  puts "Populating dummy data into #{table}..."
  require "./database/dummy_data_packs/dummy_#{table}.rb"
  puts "done"
end
