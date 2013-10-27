module ApplicationHelpers
  def set_active_navigation_link(active_id)
    self.navigation_links.each { |link| link.active = link.id == active_id }
  end

  def set_active_breadcrumb(active_id)
    self.breadcrumbs.each { |link| link.active = link.id == active_id }
  end

  def glyphicon_span(name)
    "<span class='glyphicon glyphicon-#{name}'></span>"
  end

  def stars_span(rating)
    rounded = (rating * 2).round / 2.0
    rounded = rounded.to_i if rounded == rounded.floor
    "<span class='stars s-#{rounded}' data-default='#{rounded}'> #{rounded} stars </span>"
  end

  def to_link(href, title, class_name = nil)
    class_tag = class_name.nil? ? "" : "class='#{class_name}'"
    "<a #{class_tag} href='#{href}'>#{title}</a>"
  end

  def logged?
    not session[:user].nil?
  end

  def logged_user
    User.find(id: session[:user]) if logged?
  end

  def unread_notifications
    Notification.where(user_id: logged_user.id, is_read: false).to_a if logged?
  end

  def unread_notifications?
    unread_notifications && unread_notifications.count.nonzero?
  end

  def show_print_table(prints, ratings_last_month = false)
    @prints_collection = prints
    @ratings_last_month = ratings_last_month
    erb :'prints_table.html'
  end
end
