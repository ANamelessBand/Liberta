class ProfileController < ApplicationController
  helpers ProfileHelpers
  
  before do
    set_active_navigation_link(NavigationLink.books_id)
  end

  get '/' do
    redirect '/login' unless session['user']
    show_for_user session['user']  
  end

  get '/:id' do
    session['user'] = get_user_by_id(params[:id])
    show_for_user session['user']
  end

  def show_for_user(user)
    @user = user
    @title = "#{user}'s Profile"
    erb :'profile.html'
  end
end