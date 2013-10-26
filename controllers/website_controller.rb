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
    @title = "Вход"
    erb :'login.html'
  end

  post '/login' do
    username = params[:username]
    password = params[:password]

    @user = User.find(username: username)
    redirect '/login' if @user.nil?

    # Auth logic here, currently we skip it
    session[:user] = @user
    redirect '/'
  end

  get '/logout' do
    session[:user] = nil
    redirect '/'
  end

end
