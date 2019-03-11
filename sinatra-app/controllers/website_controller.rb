module Liberta
  class WebsiteController < ApplicationController
    NAMESPACE = '/'.freeze

    helpers WebsiteHelpers

    before do
      set_active_navigation_link NavigationLink.news_id
    end

    not_found do
      @title = '404: Droid not found'
      erb :'not_found.html'
    end

    [NAMESPACE, '/news'].each do |page|
      get page do
        @title = 'Libertà'

        @last_news   = News.newest.take  LAST_NEWS_COUNT
        @last_prints = Print.newest.take LAST_PRINTS_COUNT

        erb :'index.html'
      end
    end

    get '/login' do
      @title = 'Вход'

      erb :'login.html'
    end

    post '/login' do
      username = params[:username]
      password = params[:password]

      if login(username, password)
        redirect NAMESPACE
      else
        redirect '/login'
      end
    end

    get '/logout' do
      logout

      redirect NAMESPACE
    end

    get '/notification/:id' do
      Notification.mark_read params[:id]

      redirect NAMESPACE
    end

    post '/add-news' do
      title   = params[:news_title]
      content = params[:news_content]

      add_news title, content

      redirect NAMESPACE
    end
  end
end
