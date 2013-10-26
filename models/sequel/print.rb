#maybe done
class Print < Sequel::Model
  many_to_many :authors, :key=>:id
  many_to_many :tags, :key=>:id
  many_to_one :publishers
  one_to_many :copies
  one_to_many :formats
  one_to_many :recommendations
end
