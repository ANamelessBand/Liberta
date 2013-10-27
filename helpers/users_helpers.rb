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
end