class WebsiteController < ApplicationController
  get '/' do
    set_active_navigation_link(NavigationLink.news_id)
    @title = "Liberta"
    erb :'index.html'
  end
end