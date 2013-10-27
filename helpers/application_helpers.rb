module ApplicationHelpers
  def set_active_navigation_link(active_id)
    self.navigation_links.each { |link| link.active = link.id == active_id }
  end

  def glyphicon_span(name)
    "<span class='glyphicon glyphicon-#{name}'></span>"
  end

  def stars_span(rating, interactive = false)
    rounded = (rating * 2).round / 2.0
    rounded = rounded.to_i if rounded == rounded.floor

    interactive_class = interactive ? "interactive" : ""

    html = "<span class='stars s-#{rounded} #{interactive_class}' data-default='#{rounded}'>"
    if interactive
      html += "<input type='hidden' value='#{rating}' name='rating' />"
    end

    html + "#{rounded} stars </span>"
  end

  def to_link(href, title, class_name = nil)
    class_tag = class_name.nil? ? "" : "class='#{class_name}'"
    "<a #{class_tag} href='#{href}'>#{title}</a>"
  end
end
