require 'date'

require './models/sequel/print_utils.rb'
Dir.glob('./models/sequel/*.rb').each { |file| require file }
require './database/presentation_dummy_data/dummy_data'
