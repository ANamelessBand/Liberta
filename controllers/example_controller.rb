class ExampleController < ApplicationController
  get '/:name' do
    @name = params[:name]
    erb :'index.html'
  end
end