require 'sequel'

Sequel.sqlite('liberta.db')

require './print'
require './publisher'
require './author'
require './tag'


author = Author.new name: 'Gogo'
publisher = Publisher.new name: 'Fmi'
tag = Tag.new name: 'maths'
author.save()
publisher.save()
tag.save()
# print = Print.new ({:pages=>120, :price=>12.5, :name=>'Magazine',
#                   :language=>'bg', :isbn=>'99921-58-10-7',
#                   :Description=>'Test', :publisher_id=>publisher.id})
# print.save()