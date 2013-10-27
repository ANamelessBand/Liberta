class UsersController < ApplicationController

  before do
    set_active_navigation_link(NavigationLink.users_id)
  end

  get '/' do
    @title = "Users"
    erb :'index.html'
  end

  get '/:id' do
    @user = User.find id: params[:id]
    @title = "#{@user.name.split(" ").first}'s Profile"

    @own_profile = logged? and logged_user.equal? @user

    erb :'profile.html'
  end

  get '/:id/recommendations' do
    @user = User.find id: params[:id]
    erb :'recommendations.html'
  end

  get '/:id/read' do
    @user = User.find id: params[:id]
    erb :'read.html'
  end

   get '/:id/wishlist' do
    @user = User.find id: params[:id]
    erb :'wishlist.html'
  end
end