class User < Sequel::Model
  plugin :validation_helpers

  one_to_many :notifications
  one_to_many :recommendations
  one_to_many :loans
  one_to_many :wishlists

  def validate
    super
    validates_presence [:username, :name, :faculty_number, :email, :authorization_level, :is_active]
    validates_unique :username, :faculty_number, :email
    validates_includes [0, 1, 2], :authorization_level
  end
end
