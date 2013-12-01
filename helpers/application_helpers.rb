module Liberta
  module ApplicationHelpers
    def set_active_navigation_link(active_id)
      navigation_links.each { |link| link.active = link.id == active_id }
    end

    def glyphicon_span(name)
      "<span class='glyphicon glyphicon-#{name}'></span>"
    end

    def stars_span(rating, interactive = false)
      rounded = (rating * 2).round / 2.0
      rounded = rounded.to_i if rounded == rounded.floor

      interactive_class = interactive ? 'interactive' : ''

      html = "<span class='stars s-#{rounded} #{interactive_class}'"\
             "data-default='#{rounded}'>"
      if interactive
        html += "<input type='hidden' value='#{rating}' name='rating' />"
      end

      "#{html}#{rounded} stars </span>"
    end

    def to_link(href, title, class_name = nil)
      class_tag = class_name.nil? ? '' : "class='#{class_name}'"
      "<a #{class_tag} href='#{href}'>#{title}</a>"
    end

    def show_print_table(prints, ratings_last_month = false)
      @prints_collection  = prints
      @ratings_last_month = ratings_last_month

      erb :'prints_table.html'
    end

    def logged?
      !session[:user].nil?
    end

    def logged_user
      User.find(id: session[:user]) if logged?
    end

    def administrator?
      logged? && logged_user.administrator?
    end

    def authors_html(print)
      print.authors.map do |author|
        to_link "/authors/#{author.id}", author.name
      end.join(', ')
    end

    def notify_copy_is_free(print)
      User.wishing(print).each do |user|
        Notification.free_copy user, print
      end
    end

    def show_loans_table(loans, returned = false, supposed_return = false)
      @loans           = loans
      @returned        = returned
      @supposed_return = supposed_return

      erb :'loans_table.html'
    end

    def show_recommendations_table(prints)
      @prints = prints

      erb :'recommendations_table.html'
    end
  end
end
