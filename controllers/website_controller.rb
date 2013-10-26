class WebsiteController < ApplicationController
  helpers WebsiteHelpers

  before do
    set_active_navigation_link(NavigationLink.news_id)
  end

  get /(^\/$|^\/news$)/ do
    @title = "Liberta"
    @last_added = Print.all.sort{ |x, y| y.date_added <=> x.date_added }.take(5)
    erb :'index.html'
  end

  get '/login' do
    @title = "Login"
    erb :'login.html'
  end

  post '/login' do
    username = params[:username]
    password = params[:password]
    #Auth logic here, currently we skip it
    session[:user] = username
    @user = username
    erb :'profile.html'
  end
end
