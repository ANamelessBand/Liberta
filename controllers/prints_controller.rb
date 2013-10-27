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

    names = session[:last_search_names]
    authors = session[:last_search_authors]
    tags = session[:last_search_tags]
    publishers = session[:last_search_publishers]
    searchables = session[:last_search_searchables]

    search_results = Print.all

    if searchables.empty?
      search_results = search_results.select do |result| 
        names.map { |name| result.title.downcase.include?(name.downcase) }.all?
      end
      search_results = search_results.select do |result| 
        authors.map { |author| result.authors_string.downcase.include?(author.downcase) }.all?
      end
      search_results = search_results.select do |result| 
        tags.map { |tag| result.tags_string.downcase.include?(tag.downcase) }.all?
      end
      search_results = search_results.select do |result| 
        publishers.map { |publisher| result.publisher.name.downcase.include?(publisher.downcase) }.all?
      end
    else
      search_results = search_results.select do |result| 
        searchables.map { |searchable| result.searchables_string.downcase.include?(searchable.downcase) }.all?
      end
    end

    @page_count = (search_results.size.to_f / SEARCH_RESULT_BY_PAGE).ceil
    @shown_results = search_results.drop((@current_page - 1) * SEARCH_RESULT_BY_PAGE).take(SEARCH_RESULT_BY_PAGE)

    erb :'search.html'
  end

  post '/search' do
    session[:last_search_names] = (params[:name] || "").split(' ');
    session[:last_search_authors] = (params[:author] || "").split(' ');
    session[:last_search_tags] = (params[:tags] || "").split(' ');
    session[:last_search_publishers] = (params[:publisher] || "").split(' ');
    session[:last_search_searchables] = (params[:searchables] || "").split(' ');

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
