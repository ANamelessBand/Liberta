class WebsiteController < ApplicationController
  NAMESPACE = '/'

  helpers WebsiteHelpers

  before do
    set_active_navigation_link NavigationLink.news_id
  end

  not_found do
    @title = "404: Droid not found"
    erb :'not_found.html'
  end

  get /(^\/$|^\/news$)/ do
    @title = "Libertà"

    @last_five_news = News.newest.take  SEARCH_RESULTS_PER_PAGE
    @last_prints    = Print.newest.take SEARCH_RESULTS_PER_PAGE

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
    read_notification params[:id]

    @title = "Грешка"
    erb "You should not be here. Please go home"
  end

  get '/authors/:id/all' do
    @breadcrumbs << NavigationLink.new(0,
                                       "/authors/#{params[:id]}",
                                       "Автор")
    @breadcrumbs << NavigationLink.new(0,
                                       "/authors/#{params[:id]}/all",
                                       "Всички публикации")

    author      = get_author params[:id]
    @title      = "Всички книги от #{author.name}"
    @top_prints = author.top_prints
    @id         = author.id
    @show_all   = true

    erb :'prints_by.html'
  end

  get '/authors/:id' do
    @breadcrumbs << NavigationLink.new(0,
                                       "/authors/#{params[:id]}",
                                       "Автор")

    author      = get_author params[:id]
    @title      = "Книги от #{author.name}"
    @top_prints = author.top_prints.take 5
    @id         = author.id
    @show_all   = false

    erb :'prints_by.html'
  end

  get '/publishers/:id/all' do
    @breadcrumbs << NavigationLink.new(0,
                                       "/publishers/#{params[:id]}",
                                       "Издател")
    @breadcrumbs << NavigationLink.new(0,
                                       "/publishers/#{params[:id]}/all",
                                       "Всички публикации")

    publisher   = get_publisher(params[:id])
    @title      = "Всички книги от #{publisher.name}"
    @top_prints = publisher.top_prints
    @id         = publisher.id
    @show_all   = true

    erb :'prints_by.html'
  end

  get '/publishers/:id' do
    @breadcrumbs << NavigationLink.new(0,
                                       "/publishers/#{params[:id]}/all",
                                       "Издател")

    publisher   = get_publisher(params[:id])
    @title      = "Книги от #{publisher.name}"
    @top_prints = publisher.top_prints.take 5
    @id         = publisher.id
    @show_all   = false

    erb :'prints_by.html'
  end

  post '/add-news' do
    title   = params[:news_title]
    content = params[:news_content]

    add_news title, content

    redirect '/'
  end
end
