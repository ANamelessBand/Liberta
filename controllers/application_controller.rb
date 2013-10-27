class ApplicationController < Sinatra::Base
  attr_reader :navigation_links
  attr_reader :breadcrumbs
  helpers ApplicationHelpers
  helpers WebsiteHelpers
  helpers PrintsHelpers
  helpers UsersHelpers

  before do
    @navigation_links = [NavigationLink.new(NavigationLink.news_id, "/news", "Новини"),
                        NavigationLink.new(NavigationLink.prints_id, "/prints", "Библиотека"),
                        NavigationLink.new(NavigationLink.most_liked_id, "/prints/most-liked", "Най-харесвани"),
                        NavigationLink.new(NavigationLink.users_id, "/users", "Потребители")]

    @breadcrumbs = [NavigationLink.new(0, "/news", "Начало")]
  end

  configure :development do
    register Sinatra::Reloader
  end

  configure :production do
    disable :show_exceptions
  end

  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)
  enable :sessions, :method_override

  not_found do
    @title = "404: Droid not found"
    erb :'not_found.html'
  end
end
