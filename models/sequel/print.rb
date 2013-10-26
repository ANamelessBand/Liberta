class Print < Sequel::Model
  many_to_one :publishers, :key=>:id, :primary_key=>:publisher_id
  many_to_many :authors
  many_to_many :tags
end
