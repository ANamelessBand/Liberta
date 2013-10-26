class Wishlist < Sequel::Model
  many_to_one :user
  many_to_one :print
end