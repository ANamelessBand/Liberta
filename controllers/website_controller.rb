class WebsiteController < ApplicationController

  helpers WebsiteHelpers

  before do
    set_active_navigation_link(NavigationLink.news_id)
  end

  get /(^\/$|^\/news$)/ do
    @title = "Libertà"

    @last_five_news = News.newest.take 5
    @last_added = Print.newest.take 5

    erb :'index.html'
  end

  get '/login' do
    @title = "Вход"

    erb :'login.html'
  end

  post '/login' do
    username = params[:username]
    password = params[:password]

    if login username, password
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/logout' do
    logout

    redirect '/'
  end

  get '/notification/:id' do
    notification_id = params[:id]
    read_notification notification_id

    @title = "Грешка"
    erb "You should not be here. Please go home"
  end

  get '/authors/:id/all' do
    @breadcrumbs << NavigationLink.new(0, "/authors/#{params[:id]}", "Автор")
    @breadcrumbs << NavigationLink.new(0, "/authors/#{params[:id]}/all", "Всички публикации")

    @author = get_author(params[:id])
    @title = "Всички книги от #{@author.name}"
    @top_prints = @author.top_prints
    @show_all = true

    erb :'prints_per_author.html'
  end

  get '/authors/:id' do
    @breadcrumbs << NavigationLink.new(0, "/authors/#{params[:id]}", "Автор")

    @author = get_author(params[:id])
    @title = "Книги от #{@author.name}"
    @top_prints = @author.top_prints.take 5
    @show_all = false

    erb :'prints_per_author.html'
  end

  get '/publishers/:id/all' do
    @breadcrumbs << NavigationLink.new(0, "/publishers/#{params[:id]}", "Издател")
    @breadcrumbs << NavigationLink.new(0, "/publishers/#{params[:id]}/all", "Всички публикации")

    @publisher = get_publisher(params[:id])
    @title = "Всички книги от #{@publisher.name}"
    @top_prints = @publisher.top_prints
    @show_all = true

    erb :'prints_per_publisher.html'
  end

  get '/publishers/:id' do
    @breadcrumbs << NavigationLink.new(0, "/publishers/#{params[:id]}/all", "Издател")

    @publisher = get_publisher(params[:id])
    @title = "Книги от #{@publisher.name}"
    @top_prints = @publisher.top_prints.take 5
    @show_all = false

    erb :'prints_per_publisher.html'
  end

  post '/add-news' do
    title = params[:news_title]
    content = params[:news_content]

    add_news title, content

    redirect '/'
  end
end
