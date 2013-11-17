require 'date'
Dir.glob('./models/sequel/*.rb').each { |file| require file }
require './database/presentation_dummy_data/dummy_data'
