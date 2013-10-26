class PrintsController < ApplicationController
  helpers PrintsHelpers

  get '/' do
    set_active_navigation_link(NavigationLink.prints_id)
    @title = "Prints"

    erb :'index.html'
  end

  get '/:id' do
    @title = "Яката работа"
    @print = Print.find(id: 1)
    erb :'print.html'
  end

  get '/most-liked' do
    set_active_navigation_link(NavigationLink.most_liked_id)
    @title = "Most Liked"

    erb :'index.html'
  end
end
