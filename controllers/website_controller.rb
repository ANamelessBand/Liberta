class WebsiteController < ApplicationController
  get '/' do
    @title = "Liberta"
    erb :'index.html'
  end
end