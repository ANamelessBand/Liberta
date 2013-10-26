class WebsiteController < ApplicationController
  before do
    set_active_navigation_link(NavigationLink.news_id)
  end
  get '/' do
    @title = "Liberta"
    erb :'index.html'
  end
end