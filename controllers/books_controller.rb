class BooksController < ApplicationController
  helpers BooksHelpers

  get '/' do
    set_active_navigation_link(NavigationLink.books_id)
    @title = "books"

    erb :'index.html'
  end

  get '/most-liked' do
    set_active_navigation_link(NavigationLink.most_liked_id)
    @title = "Most Liked"

    erb :'index.html'
  end
end
