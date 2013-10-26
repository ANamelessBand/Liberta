class Print < Sequel::Model
  many_to_many :authors, key: :id
  many_to_many :tags, key: :id
  many_to_many :formats, key: :id
  many_to_one :publishers, key: :id, primary_key: :publisher_id
  one_to_many :copies
  one_to_many :recommendations
end
