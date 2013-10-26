require 'sequel'

Sequel.sqlite('liberta.db')

require './../models/sequel/format'

Format.create(:name=>"book")
Format.create(:name=>"magazine")
Format.create(:name=>"newspaper")
Format.create(:name=>"publication")