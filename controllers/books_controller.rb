class BooksController < ApplicationController
  helpers BooksHelpers

  before do
    set_active_navigation_link(NavigationLink.books_id)
  end

  get '/' do
    @title = "News"
    erb :'index.html'
  end

  get '/most-liked' do
    @title = "Most Liked"
    erb :'index.html'
  end
end