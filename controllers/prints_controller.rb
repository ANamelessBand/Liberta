class PrintsController < ApplicationController
  NAMESPACE = '/prints'

  before do
    @breadcrumbs << NavigationLink.new(0, "/prints", "Книги")
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
    @breadcrumbs << NavigationLink.new(0, "/search/#{params[:page]}", "Резултати от търсенето")
    @title = "Резултати от търсенето"

    names       = (params[:names] || "").split(',')
    authors     = (params[:authors] || "").split(',')
    tags        = (params[:tags] || "").split(',')
    publishers  = (params[:publishers] || "").split(',')
    searchables = (params[:searchables] || "").split(',')

    dataset = Print.join(:authors_prints, authors_prints__print_id: :prints__id).
                    join(:authors, authors__id: :authors_prints__author_id).
                    join(:publishers, publishers__id: :prints__publisher_id).
                    join(:prints_tags, prints_tags__print_id: :prints__id).
                    join(:tags, tags__id: :prints_tags__tag_id)

    if searchables.empty?
      dataset = dataset.where(Sequel.ilike(:prints__title, "%#{names.first}%"))
      names.each do |name|
        dataset = dataset.where(Sequel.ilike(:prints__title, "%#{name}%"))
      end

      authors.each do |author|
        dataset = dataset(Sequel.ilike(:authors__name, "%#{author}%"))
      end

      publishers.each do |publisher|
        dataset = dataset(Sequel.ilike(:publishers__name, "%#{publisher}%"))
      end

      tags.each do |tag|
        dataset = dataset(Sequel.ilike(:tags__name, "%#{tag}%"))
      end
    else
      join_clause = Sequel.join([:prints__title, :authors__name, :publishers__name, :tags__name], ' ')
      searchables.each do |searchable|
        dataset = dataset.where(join_clause.ilike("%#{searchable}%"))
      end
    end

    search_results = dataset.select_all(:prints).distinct
    @shown_results = search_results.paginate(params[:page].to_i, SEARCH_RESULTS_PER_PAGE)
    erb :'search.html'
  end

  post '/search' do
    names       = params[:name].to_s.gsub(' ', ',')
    authors     = params[:author].to_s.gsub(' ', ',')
    tags        = params[:tags].to_s.gsub(' ', ',')
    publishers  = params[:publisher].to_s.gsub(' ', ',')
    searchables = params[:searchables].to_s.gsub(' ', ',')
    redirect "prints/search/1?"\
              "names=#{names}&"\
              "authors=#{authors}&"\
              "tags=#{tags}&"\
              "publishers=#{publishers}&"\
              "searchables=#{searchables}"
  end

  get '/most-liked' do
    @breadcrumbs << NavigationLink.new(0, "/prints/most-liked", "Най-харесвани")

    @title = "Най-харесвани книги"
    all_prints = Print.all

    @all_time_prints = all_prints.sort { |x, y| y.rating(false) <=> x.rating(false) }.take 5
    @last_month_prints = all_prints.sort { |x, y| y.rating(true) <=> x.rating(true) }.take 5

    erb :'most_liked.html'
  end

  get '/:id' do
    @print = Print.find(id: params[:id])
    @title = @print.title
    @current_recommendation = logged? && Recommendation.find({user: logged_user, print: @print})

    @breadcrumbs << NavigationLink.new(0, "/prints/#{params[:id]}", "#{@print.title}")

    erb :'print.html'
  end

  post '/:id/add-recommendation' do
    rating  = params[:rating]
    comment = params[:recommendation_comment]

    back = "/prints/#{params[:id]}"
    redirect back if rating == 0

    current_user = logged_user
    current_print = Print.find(id: params[:id])
    date = Date.today

    recommendation = Recommendation.find({user: current_user, print: current_print})
    if recommendation.nil?
      Recommendation.create rating: rating, comment: comment, date_of_comment: date, user: current_user, print: current_print
    else
      recommendation.update({rating: rating, comment: comment, date_of_comment: date})
    end

    redirect back
  end

  get '/:id/add-wishlist' do
    @print = Print.find(id: params[:id])

    Wishlist.create(user: logged_user, print: @print, is_satisfied: false) unless logged_user.has_wish(@print)

    back = "/prints/" + @print.id.to_s
    redirect back
  end

  get '/:id/remove-wishlist' do
    @print = Print.find(id: params[:id])

    wishlist = logged_user.wishlists.select { |wishlist| wishlist.print.id == @print.id }.first

    unless wishlist.nil?
      wishlist.delete
    end

    back = "/prints/" + @print.id.to_s
    redirect back
  end

  get '/:id/:copy_id' do
    @copy  = Copy.find(inventory_number: params[:copy_id].to_i)
    @print = @copy.print
    @title = "#{@print.title} - #{@copy.inventory_number}"

    @breadcrumbs << NavigationLink.new(0, "/prints/#{params[:id]}", "#{@print.title}")
    @breadcrumbs << NavigationLink.new(0, "/prints/#{params[:id]}/#{params[:copy_id]}", "#{@print.title} - #{@copy.inventory_number}")

    erb :'copy.html'
  end

  get '/:id/:copy_id/return' do
    @copy  = Copy.find(inventory_number: params[:copy_id].to_i)
    @print = @copy.print
    @loan  = @copy.loans.reject(&:date_returned).last

    @breadcrumbs << NavigationLink.new(0, "/prints/#{params[:id]}", "#{@print.title}")
    @breadcrumbs << NavigationLink.new(0, "/prints/#{params[:id]}/#{params[:copy_id]}", "#{@print.title} - #{@copy.inventory_number}")

    return_loan @loan

    notify_copy_is_free @print

    back = "/prints/#{@print.id}/#{@copy.inventory_number}"
    redirect back
  end
end

