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
    @user = params[:id]
    @title = "#{@user}'s Profile"
    erb :'profile.html'
  end

  def show_profile(user)
    
  end
end