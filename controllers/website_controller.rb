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

  def set_data(clas, id)
    @contributor = clas.find id: id
    @title = @contributor.name
  end

  get '/author/:id/all' do
    @breadcrumbs << NavigationLink.new(0, "/author/#{params[:id]}", "Автор")
    @breadcrumbs << NavigationLink.new(0, "/author/#{params[:id]}/all", "Всички публикации")
    set_data Author, params[:id]
    erb :'contributor_all.html'
  end

  get '/author/:id' do
    @breadcrumbs << NavigationLink.new(0, "/author/#{params[:id]}", "Автор")
    set_data Author, params[:id]
    erb :'contributor.html'
  end

  get '/publisher/:id/all' do
    @breadcrumbs << NavigationLink.new(0, "/publisher/#{params[:id]}/all", "Издател")
    @breadcrumbs << NavigationLink.new(0, "/author/#{params[:id]}", "Всички публикации")
    set_data Publisher, params[:id]
    erb :'contributor_all.html'
  end

  get '/publisher/:id' do
    @breadcrumbs << NavigationLink.new(0, "/publisher/#{params[:id]}/all", "Издател")
    set_data Publisher, params[:id]
    erb :'contributor.html'
  end
end
