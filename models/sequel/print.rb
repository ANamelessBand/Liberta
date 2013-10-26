class Print < Sequel::Model
  many_to_many :authors
  many_to_many :tags
  many_to_one :format
  many_to_one :publisher
  one_to_many :copies
  one_to_many :recommendations
  one_to_many :wishlists
end
