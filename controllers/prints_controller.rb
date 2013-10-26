class PrintsController < ApplicationController
  helpers PrintsHelpers

  before do
    if request.path_info == '/most-liked'
      set_active_navigation_link NavigationLink.most_liked_id
    else
      set_active_navigation_link NavigationLink.prints_id
    end
  end

  get '/' do
    @title = "Търсене в библиотеката"

    erb :'prints.html'
  end

  get '/search/:page' do
    @title = "Резултати от търсенето"
    @current_page = params[:page].to_i
    search_results = session[:last_search_data]
    @page_count = (search_results.size.to_f / SEARCH_RESULT_BY_PAGE).ceil
    @shown_results = search_results.drop((@current_page - 1) * SEARCH_RESULT_BY_PAGE).take(SEARCH_RESULT_BY_PAGE)

    erb :'search.html'
  end

  post '/search' do
    search_results = Print.all
    session[:last_search_data] = search_results
    redirect '/prints/search/1'
  end

  get '/:id' do
    @print = Print.find(id: params[:id])
    @title = @print.title
    erb :'print.html'
  end

  get '/most-liked' do
    
    @title = "Most Liked"

    erb :'index.html'
  end
end
