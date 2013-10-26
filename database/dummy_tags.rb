require 'sequel'

Sequel.sqlite('liberta.db')

require './../models/sequel/tag'

Tag.create(:name=>'Roman')
Tag.create(:name=>'Novel')
Tag.create(:name=>'Programming')
Tag.create(:name=>'Art')
Tag.create(:name=>'Music')
Tag.create(:name=>'Java')
Tag.create(:name=>'C#')
Tag.create(:name=>'Ruby')
Tag.create(:name=>'Python')
Tag.create(:name=>'SciFi')
Tag.create(:name=>'Crime fiction')
Tag.create(:name=>'Adventure')
Tag.create(:name=>'Stories')
Tag.create(:name=>'Audiobook')
Tag.create(:name=>'Poetry')
Tag.create(:name=>'Classic')
Tag.create(:name=>'Fiction')
Tag.create(:name=>'Fantasy')
Tag.create(:name=>'Science')
Tag.create(:name=>'Health')
Tag.create(:name=>'History')
Tag.create(:name=>'Horror')