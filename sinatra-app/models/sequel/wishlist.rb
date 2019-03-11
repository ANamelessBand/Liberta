class Wishlist < Sequel::Model
  many_to_one :user
  many_to_one :print

  def satisfy
    update is_satisfied: true
  end

  class << self
    def add(user, print)
      unless user.wish? print
        create user: user, print: print, is_satisfied: false
      end
    end

    def remove(user, print)
      where(user_id: user.id, print_id: print.id).each &:delete
    end
  end
end
