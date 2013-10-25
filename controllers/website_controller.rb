class WebsiteController < ApplicationController
  get '/' do
    @name = "Unknown"
    erb :'index.html'
  end
end