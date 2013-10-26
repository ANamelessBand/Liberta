require 'sequel'

Sequel.sqlite('./liberta.db')


Dir.glob('./../models/sequel/*.rb').each { |file| require file }

require './dummy_data_packs/dummy_authors.rb'
require './dummy_data_packs/dummy_tags.rb'
require "./dummy_data_packs/dummy_formats.rb"
