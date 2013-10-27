module UsersHelpers
  def logged?
    not session[:user].nil?
  end

  def logged_user
    User.find(id: session[:user]) if logged?
  end

  def admin?
    logged? and logged_user.authorization_level == 0
  end

  def unread_notifications
    Notification.where(user_id: logged_user.id, is_read: false).to_a if logged?
  end

  def unread_notifications?
    unread_notifications && unread_notifications.count.nonzero?
  end

  def notify_all_copies_taken(print)
    Wishlist.where(print: print).each do |user_wish|
      user = user_wish.user
      Notification.create user: user,
                          message: "Копията на #{print.title} са изчерпани.",
                          is_read: false
    end
  end

  def remove_from_wishlist(user, print)
    Wishlist.where(user: user, print: print).each do |user_wish|
      user_wish.satisfied = true
      user_wish.save
    end
  end

  def loan_copy(user, copy)
    Loan.create date_loaned: Date.today,
                date_supposed_return: Date.today + 31,
                copy: copy,
                user: user

    copy.is_taken = true
    copy.save

    remove_from_wishlist user, copy.print
    notify_all_copies_taken copy.print if copy.print.copies.all? { |copy| copy.is_taken }
  end
end
