# frozen_string_literal: true

module ApplicationHelper
  def navbar_item_class(for_path)
    ["navbar-item", current_page?(for_path) ? "is-active" : ""]
  end

  def icon_with_text(icon, text, is_small = false)
    icon_tag = content_tag(:span, class: ["icon", is_small ? "is-small" : ""]) do
      fa_icon icon
    end

    text_tag = content_tag(:span, text)

    [icon_tag, text_tag].join.html_safe
  end

  def authors_html(print)
    print.authors.map { |author| link_to author.name, author }.join(", ").html_safe
  end

  def stars_span(rating, interactive = false)
    rounded = (rating * 2).round / 2.0
    rounded = rounded.to_i if rounded == rounded.floor

    interactive_class = interactive ? "interactive" : ""

    content_tag(:span, class: ["stars", "s-#{rounded}", interactive_class], "data-default": rounded) do
      concat hidden_field_tag("rating", rating) if interactive
      concat "#{rounded} stars"
    end
  end

  def print_link_with_cover(print)
    if print.cover_url.present?
      link_to print.title,
          print,
          data: {
            toggle: "popover",
            placement: "bottom",
            trigger: "hover",
            content: image_tag(print.cover_url, class: "cover"),
            html: true
          }
    else
      link_to print.title, print
    end
  end
end
