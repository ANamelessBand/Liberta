class UsersController < ApplicationController
  helpers UsersHelpers

  before do
    set_active_navigation_link(NavigationLink.users_id)
  end

  get '/' do
    @title = "Users"
    erb :'index.html'
  end

  get '/:id' do
    @user = User.find id: params[:id]
    @title = "#{@user.name}'s Profile"
    erb :'profile.html'
  end

  get '/:id/recommendations' do
    @user = User.find id: params[:id]
    # erb :'recommendations.html'
  end

  get '/:id/read' do
    @user = User.find id: params[:id]
    # erb :'read.html'
  end
end