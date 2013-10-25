class ExampleController < ApplicationController
  get '/:name' do
    @title = "Example"
    @name = params[:name]
    erb :'index.html'
  end
end