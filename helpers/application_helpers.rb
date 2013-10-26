module ApplicationHelpers
  def set_active_navigation_link(active_id)
    self.navigation_links.each { |link| link.active = link.id == active_id }
  end

  def glyphicon_snap(name)
    "<span class='glyphicon glyphicon-#{name}'></span>"
  end

  def stars_span(rating)
    rounded_rating = (rating * 2).round / 2.0
    "<span class='stars s-#{rounded_rating}' data-default='#{rounded_rating}'> #{rounded_rating} stars </span>"
  end
end