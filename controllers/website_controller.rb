class WebsiteController < ApplicationController
  helpers WebsiteHelpers

  before do
    set_active_navigation_link(NavigationLink.news_id)
  end

  get /(^\/$|^\/news$)/ do
    @title = "Liberta"
    erb :'index.html'
  end

  get '/login' do
    @title = "Login"
    erb :'index.html'
  end
end