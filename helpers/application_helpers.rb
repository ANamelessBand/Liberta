module ApplicationHelpers
  def set_active_navigation_link(active_id)
    self.navigation_links.each { |link| link.active = link.id == active_id }
  end

  def glyphicon_span(name)
    "<span class='glyphicon glyphicon-#{name}'></span>"
  end

  def stars_span(rating)
    rounded = (rating * 2).round / 2.0
    rounded = rounded.to_i if rounded == rounded.ceil
    "<span class='stars s-#{rounded}' data-default='#{rounded}'> #{rounded} stars </span>"
  end

  def to_link(href, title)
    "<a href='#{href}'>#{title}</a>"
  end
end
