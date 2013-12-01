class ApplicationController < Sinatra::Base
  attr_reader :navigation_links
  attr_reader :breadcrumbs

  helpers ApplicationHelpers

  before do
    @navigation_links = [NavigationLink.new(NavigationLink.news_id,
                                            "/news",
                                            "Новини"),
                        NavigationLink.new(NavigationLink.prints_id,
                                           "/prints",
                                           "Библиотека"),
                        NavigationLink.new(NavigationLink.most_liked_id,
                                           "/prints/most-liked",
                                           "Най-харесвани"),
                        NavigationLink.new(NavigationLink.users_id, "/users", "Потребители"),]

    @breadcrumbs = [NavigationLink.new(0, "/news", "Начало")]
  end
end
