class WebsiteController < ApplicationController
  get '/' do
    @title = "Website"
    @name = "Unknown"
    erb :'index.html'
  end
end