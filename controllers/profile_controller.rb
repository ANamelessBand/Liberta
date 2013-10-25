class ProfileController < ApplicationController
  helpers ProfileHelpers

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
    erb :'profile.html'
  end
end