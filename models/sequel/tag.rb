class Tag < Sequel::Model
  many_to_many :prints, key: :id
end
