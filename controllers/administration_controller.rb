class AdministrationController <  ApplicationController

  before do
    redirect '/' unless admin? 
    @breadcrumbs << NavigationLink.new(0, "/administration", "Администриране")
  end

  get '/' do
    @title = "Администриране"
    @search = false
    @add, @remove, @loaned = "active", "", ""
    erb :'administration.html', locals: {template: :'add_print.html'}
  end

  post '/add-print' do
    @title = "Администриране"
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
    names = params[:name].gsub(' ', '+')
    redirect "administration/search/1?name=#{names}&in=#{params[:in]}"
  end

  get '/search/:page' do
    @title  = 'Администриране'
    puts params[:name]
    puts params[:in]
    @names  = params[:name].split ' '
    @in     = params[:in]
    loan_dataset = Loan.dataset.filter(date_returned: nil)

    unless @in.nil? || @in.empty?
      dataset = loan_dataset.join(Copy.where(inventory_number: @in.to_i), id: :copy_id)
    end

    @names.each do |name|
      dataset = loan_dataset.join(User.where(Sequel.ilike(:name, "%#{name}%")), id: :user_id)
    end

    @search = true
    results = dataset || loan_dataset
    @loaned_copies = results.paginate(params[:page].to_i, SEARCH_RESULT_BY_PAGE)
    @add, @remove, @loaned = "", "", "active"
    erb :'administration.html', locals: {template: :'loaned_copies.html'}
  end

  get '/loaned-copies' do
    redirect '/administration/loaned-copies/1'
  end
  
  get '/loaned-copies/:page' do
      @title = "Администриране"
      @search = true
      dataset = Loan.dataset.filter(date_returned: nil)
      @loaned_copies = dataset.paginate(params[:page].to_i, SEARCH_RESULT_BY_PAGE)
      @add, @remove, @loaned = "", "", "active"
      erb :'administration.html', locals: {template: :'loaned_copies.html'}
  end 
end

