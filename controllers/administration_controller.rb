module Liberta
  class AdministrationController <  ApplicationController
    NAMESPACE = '/administration'

    before do
      redirect '/' unless administrator?
      @breadcrumbs << NavigationLink.new(0, '/administration', 'Администриране')
    end

    get '/' do
      @title = "Администриране"
      @search = false
      @add, @remove, @loaned = "active", "", ""
      erb :'administration.html', locals: {template: :'add_print.html'}
    end

    post '/add-print' do
      # FIXME: Whoever has written this should fix it!!!
      author = Author.create name: params[:added_author_name]
      publisher = Publisher.create name: params[:added_publisher_name]
      name = params[:added_name]
      isbn = params[:added_ISBN]
      description = params[:added_description]
      pages = params[:added_pages]
      format = Format.create name: params[:added_format]
      tags = params[:added_tags].split(',')
      price = params[:added_price]
      language = params[:added_language]
      date = Date.today
      # Seriously?!
      a = params[:added_cover]

      print = Print.new title: name, language: language, isbn: isbn,
      pages: pages, date_added: date, price: price, format: format,
      publisher: publisher, description: description, cover: a
      print.save
      print.add_author author
      print.add_tag Tag.create(name: tags[0])

      Copy.create print: print, inventory_number: 123456
      redirect '/'
    end

    get '/search' do
      names = params[:name].gsub(',', ' ').gsub(' ', '+') unless params[:name].nil?
      redirect NAMESPACE + "/search/1?name=#{names}&in=#{params[:in]}"
    end

    get '/search/:page' do
      @title  = 'Администриране'
      @names  = params[:name].split ' '
      @in     = params[:in]
      dataset = Loan.dataset.filter(date_returned: nil)

      user_dataset = dataset.join(User, id: :user_id) unless @names.empty?
      @names.each do |name|
        user_dataset = user_dataset.where(Sequel.ilike(:name, "%#{name}%"))
      end

      unless @in.nil? || @in.empty?
        copy_dataset = dataset.join(Copy.where(inventory_number: @in.to_i), id: :copy_id)
      end

      if copy_dataset and user_dataset
        columns = [:copy_id, :user_id, :date_loaned, :date_supposed_return]
        result  = user_dataset.select(*columns).union(
                  copy_dataset.select(*columns))
      else
        result = user_dataset || copy_dataset || dataset
      end 

      @search = true
      @loaned_copies = result.paginate(params[:page].to_i, SEARCH_RESULTS_PER_PAGE)
      @add, @remove, @loaned = "", "", "active"
      erb :'administration.html', locals: {template: :'loaned_copies.html'}
    end
  end
end
