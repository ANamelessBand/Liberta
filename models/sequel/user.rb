class User < Sequel::Model
  one_to_many :notifications
  one_to_many :recommendations
  one_to_many :loans
end
