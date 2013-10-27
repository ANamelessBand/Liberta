class WebsiteController < ApplicationController

  before do
    set_active_navigation_link(NavigationLink.news_id)
  end

  get /(^\/$|^\/news$)/ do
    @title = "Liberta"
    @last_five_news = News.all.sort { |x, y| y.date_of_publication <=> x.date_of_publication }.take(5)
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
    session[:user] = @user.id
    redirect '/'
  end

  get '/logout' do
    session[:user] = nil
    redirect '/'
  end

  get '/notification/:id' do
    @notification = Notification.find(id: params[:id])
    @notification.is_read = true
    @notification.save

    @title = "Грешка"
    erb "You should not be here. Please go home"
  end

end
