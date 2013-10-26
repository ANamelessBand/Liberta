require 'sequel'

Sequel.sqlite('liberta.db')

require './../models/sequel/author'

Author.create(:name=>'J. J. Martin')
Author.create(:name=>'J. R. R. Talkien')
Author.create(:name=>'Terry Pratchet')
Author.create(:name=>'Ivan Vazov')
Author.create(:name=>'Hristo Botev')
Author.create(:name=>'J. K. Rowling')
Author.create(:name=>'Douglas Addams')
Author.create(:name=>'Paulo Coelho')
Author.create(:name=>'Elin Pelin')
Author.create(:name=>'Atanas Dalchev')
