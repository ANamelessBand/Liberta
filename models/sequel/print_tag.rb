require Sequel

DB = Sequel.connect('sqlite://database/liberta.db')

class PrintTags < Sequel::Model(:print_tags)
end