module UsersHelpers
  def logged?
    !session[:user].nil?
  end

  def logged_user
    User.find(id: session[:user]) if logged?
  end

  def administrator?
    logged? && logged_user.administrator?
  end

  def notify_out_of_copies(print)
    User.wishing(print).each do |user|
      Notification.out_of_copies user, print
    end
  end

  def loan_copy(user, copy)
    # TODO: consider using BD transaction here.
    Loan.add user, copy
    copy.take
    user.satisfy_wish copy.print

    notify_out_of_copies copy.print if copy.print.out_of_copies?
  end
end
