class Author < Sequel::Model
  many_to_many :prints
end