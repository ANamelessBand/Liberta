class UsersController < ApplicationController

  before do
    @breadcrumbs << NavigationLink.new(0, "/users", "Потребители")
    set_active_navigation_link(NavigationLink.users_id)
  end

  post '/search' do
    session[:last_user_search_name] = params[:name].split(' ')
    session[:last_user_search_fn] = params[:fn]
    redirect 'users/search/1'
  end

  get '/' do
    session[:last_user_search_name] = []
    session[:last_user_search_fn] = ""
    redirect '/users/search/1'
  end

  get '/search/:page' do
    @title = "Потребители"
    search_results = User.all
    @names = session[:last_user_search_name] || []
    @fn = session[:last_user_search_fn] || ""
    if @fn.empty?
      search_results = search_results.select { |user| @names.map { |name| user.name.include? name}.all? }
    else
      search_results = search_results.select { |user| user.faculty_number.to_s.include? @fn}
    end

    @page_count = (search_results.size.to_f / SEARCH_RESULT_BY_PAGE).ceil
    @current_page = params[:page].to_i
    @shown_results = search_results.drop((@current_page - 1) * SEARCH_RESULT_BY_PAGE).take(SEARCH_RESULT_BY_PAGE)
    erb :'users.html'
  end

  get '/:id' do
    @user = User.find id: params[:id]
    @title = "Профил"

    @breadcrumbs << NavigationLink.new(0, "/users/#{params[:id]}", "#{@user.name}")
    erb :'profile.html'
  end

  get '/:id/recommendations' do
    @breadcrumbs << NavigationLink.new(0, "/users/#{params[:id]}", "#{@user.name}")
    @breadcrumbs << NavigationLink.new(0, "/users/#{params[:id]}/recommendations", "Препоръки}")
    @user = User.find id: params[:id]
    erb :'recommendations.html'
  end

  get '/:id/read' do
    @breadcrumbs << NavigationLink.new(0, "/users/#{params[:id]}", "#{@user.name}")
    @breadcrumbs << NavigationLink.new(0, "/users/#{params[:id]}/read", "Прочетени Книги}")
    @user = User.find id: params[:id]
    erb :'read.html'
  end

   get '/:id/wishlist' do
    @user = User.find id: params[:id]
    erb :'wishlist.html'
  end
end