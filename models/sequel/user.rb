class User < Sequel::Model
  plugin :validation_helpers

  one_to_many :notifications
  one_to_many :recommendations
  one_to_many :loans
  one_to_many :wishlists

  def validate
    super
    validates_presence [
                          :username,
                          :name,
                          :faculty_number,
                          :email,
                          :authorization_level,
                          :is_active,
                       ]
    validates_unique :username, :faculty_number, :email
    validates_includes [0, 1, 2], :authorization_level
  end

  def active?
    is_active
  end

  def activate
    is_active = true
  end

  def activate!
    activate
    save
  end

  def deactivate
    is_active = false
  end

  def deactivate!
    deactivate
    save
  end

  def read_prints
    loans.select(&:date_returned)
  end

  def last_recommendations
    recommendations.reverse
  end

  def wishes
    wishlists.map(&:print)
  end

  def wishes?(print)
    wishlists.any? do |wish|
      wish.print.id == print.id && !wish.is_satisfied
    end
  end

  def currently_loaned
    loans.select(&:date_supposed_return)
  end

  def match_name?(name)
    self.name.downcase.include? name.downcase
  end

  def match_faculty_number?(faculty_number)
    self.faculty_number.to_s.include? faculty_number.to_s
  end

  def match_email?(email)
    self.email.downcase.include? email.downcase
  end

  def match_authorization_level?(authorization_level)
    self.authorization_level == authorization_level
  end

  def self.find_by_name(names)
    select do |user|
      names.all? { |name| user.match_name? name }
    end
  end

  def self.find_by_faculty_number(faculty_number)
    select { |user| user.match_faculty_number? faculty_number }
  end

  def loan(copy)
    loan = Loan.new date_loaned: Date.today,
                    date_supposed_return: Date.today + 31,
                    copy: copy,
                    user: self

    if loan.valid?
      loan.save
    else
      # TODO add validation logic here
    end

    copy.take!

    Wishlist.satisfy(user, print)
    notify_all_copies_taken copy.print if copy.print.copies.all? { |copy| copy.is_taken }
  end
end
