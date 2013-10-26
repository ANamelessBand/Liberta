require 'rubygems'
require 'sequel'
require 'sinatra/base'
require 'sinatra/reloader'

class ApplicationController < Sinatra::Base
  attr_reader :navigation_links
  helpers ApplicationHelpers

  before do
    @navigation_links = [NavigationLink.new(NavigationLink.news_id, "/news", "Новини"),
                        NavigationLink.new(NavigationLink.books_id, "/books", "Библиотека"),
                        NavigationLink.new(NavigationLink.most_liked_id, "/books/most-liked", "Най-харесвани"),
                        NavigationLink.new(NavigationLink.users_id, "/users", "Потребители")]
  end

  configure :development do
    register Sinatra::Reloader
  end

  configure :production do
    disable :show_exceptions
  end

  set :views, File.expand_path('../../views', __FILE__)
  set :public, File.expand_path('../../public', __FILE__)
  enable :sessions, :method_override

  not_found do
    @title = "404: droid not found"
    erb :'not_found.html'
  end
end
