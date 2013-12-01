class AdministrationController <  ApplicationController
  NAMESPACE = '/administration'

  before do
    redirect '/' unless admin?
    @breadcrumbs << NavigationLink.new(0, '/administration', 'Администриране')
  end

  get '/' do
    @title = 'Администриране'

    erb :'administration.html'
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
end

