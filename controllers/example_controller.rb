class ExampleController < ApplicationController
  get '/:name' do
    @title = params[:name]
    erb :'index.html'
  end
end