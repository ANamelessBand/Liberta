class PrintsController < ApplicationController
  helpers PrintsHelpers

  NAMESPACE = '/prints'

  before do
    @breadcrumbs << NavigationLink.new(0, '/prints', 'Книги')

    if request.path_info == '/most-liked'
      set_active_navigation_link NavigationLink.most_liked_id
    else
      set_active_navigation_link NavigationLink.prints_id
    end
  end

  get '/' do
    @title = 'Търсене в библиотеката'

    erb :'prints.html'
  end

  get '/search/:page' do
    @breadcrumbs << NavigationLink.new(0,
                                       "/search/#{params[:page]}",
                                       'Резултати от търсенето')
    @title = 'Резултати от търсенето'

    titles      = params[:titles].to_s.split ','
    authors     = params[:authors].to_s.split ','
    tags        = params[:tags].to_s.split ','
    publishers  = params[:publishers].to_s.split ','
    searchables = params[:searchables].to_s.split ','

    search_results = search titles, authors, tags, publishers, searchables
    @shown_results = search_results.paginate(params[:page].to_i,
                                             SEARCH_RESULTS_PER_PAGE)

    erb :'search.html'
  end

  post '/search' do
    titles      = params[:title].to_s.gsub ' ', ','
    authors     = params[:author].to_s.gsub ' ', ','
    tags        = params[:tags].to_s.gsub ' ', ','
    publishers  = params[:publisher].to_s.gsub ' ', ','
    searchables = params[:searchables].to_s.gsub ' ', ','

    redirect "prints/search/1?"\
             "titles=#{titles}&"\
             "authors=#{authors}&"\
             "tags=#{tags}&"\
             "publishers=#{publishers}&"\
             "searchables=#{searchables}"
  end

  get '/most-liked' do
    @breadcrumbs << NavigationLink.new(0,
                                       '/prints/most-liked',
                                       'Най-харесвани')

    @title = 'Най-харесвани книги'

    @all_time_prints   = Print.best.take            SEARCH_RESULTS_PER_PAGE
    @last_month_prints = Print.best_last_month.take SEARCH_RESULTS_PER_PAGE

    erb :'most_liked.html'
  end

  get '/:id' do
    @print = Print.find(id: params[:id])
    @title = @print.title
    @current_recommendation = logged? &&
                              Recommendation.find(user: logged_user,
                                                  print: @print)

    @breadcrumbs << NavigationLink.new(0,
                                       "/prints/#{params[:id]}",
                                       "#{@print.title}")

    erb :'print.html'
  end

  post '/:id/add-recommendation' do
    rating  = params[:rating].to_f
    comment = params[:recommendation_comment]

    unless rating.zero?
      print = Print.find id: params[:id]

      Recommendation.add logged_user, print, rating, comment
    end

    redirect "/prints/#{params[:id]}"
  end

  get '/:id/add-wishlist' do
    print = Print.find id: params[:id]

    Wishlist.add logged_user, print

    redirect "/prints/#{print.id}"
  end

  get '/:id/remove-wishlist' do
    print = Print.find id: params[:id]

    Wishlist.remove logged_user, print

    redirect "/prints/#{print.id}"
  end

  get '/:id/:copy_id' do
    @copy  = Copy.find inventory_number: params[:copy_id].to_i
    @print = @copy.print
    @title = "#{@print.title} - #{@copy.inventory_number}"

    @breadcrumbs << NavigationLink.new(0,
                                       "/prints/#{params[:id]}",
                                       "#{@print.title}")
    @breadcrumbs << NavigationLink.new(0,
                                       "/prints/#{params[:id]}/#{params[:copy_id]}",
                                       "#{@print.title} - #{@copy.inventory_number}")

    erb :'copy.html'
  end

  get '/:id/:copy_id/return' do
    copy  = Copy.find inventory_number: params[:copy_id].to_i
    print = copy.print
    loan  = copy.current_loan

    @breadcrumbs << NavigationLink.new(0,
                                       "/prints/#{params[:id]}",
                                       "#{print.title}")
    @breadcrumbs << NavigationLink.new(0,
                                       "/prints/#{params[:id]}/#{params[:copy_id]}",
                                       "#{print.title} - #{copy.inventory_number}")

    loan.return

    notify_copy_is_free print

    redirect "/prints/#{print.id}/#{copy.inventory_number}"
  end
end
