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

  def read
    loans.select(&:date_returned)
  end

  def last_recommendations(number)
    recommendations.reverse.take number
  end

  def wishes
    wishlists.map(&:print)
  end

  def has_wish(print)
    wishlists.any? do |wish|
      wish.print.id == print.id
    end
  end

  def currently_loaned
    loans.select { |loan| loan.date_supposed_return > Date.today }
  end
end
