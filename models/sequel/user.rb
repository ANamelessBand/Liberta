class User < Sequel::Model
  one_to_many :notifications, :recommendations, :loans
end