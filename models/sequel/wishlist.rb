class Wishlist < Sequel::Model
  many_to_one :user
  many_to_one :print

  def satisfy
    is_satisfied = true
  end

  def satisfy!
    satisfy
    save
  end

  def self.satisfy_wishes(user, print)
    Wishlist.where(user: user, print: print).each do |user_wish|
      user_wish.satisfy!
    end
  end
end
