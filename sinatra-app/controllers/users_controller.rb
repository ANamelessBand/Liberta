module Liberta
  class UsersController < ApplicationController
    helpers UsersHelpers

    NAMESPACE = '/users'.freeze

    before do
      @breadcrumbs << NavigationLink.new(0, NAMESPACE, 'Потребители')

      set_active_navigation_link(NavigationLink.users_id)
    end

    get '/settings' do
      @breadcrumbs << NavigationLink.new(0, '/settings', 'Настройки')

      redirect '/login' unless logged?

      @title = 'Настройки'

      erb :'settings.html'
    end

    post '/settings' do
      email = params[:email]
      #avatar = params[:avatar]

      logged_user.update email: email

      redirect "#{NAMESPACE}/settings"
    end

    post '/search' do
      names = params[:name].to_s.split ','

      redirect "#{NAMESPACE}/search/1?name=#{names}&fn=#{params[:fn]}"
    end

    get '/' do
      redirect "#{NAMESPACE}/search/1"
    end

    get '/search/:page' do
      @title  = 'Потребители'
      @names  = params[:name].to_s.split ','
      @fn     = params[:fn]
      dataset = User.dataset

      unless @fn.nil? || @fn.empty?
        dataset = dataset.where faculty_number: @fn.to_i
      end

      @names.each do |name|
        dataset = dataset.where Sequel.ilike(:name, "%#{name}%")
      end

      @shown_results = dataset.paginate(params[:page].to_i,
                                        SEARCH_RESULTS_PER_PAGE)

      erb :'users.html'
    end

    get '/:id' do
      @user        = User.find id: params[:id]
      @title       = 'Профил'

      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}", "#{@user.name}")

      erb :'profile.html'
    end

    get '/:id/recommendations' do
      @user = User.find id: params[:id]

      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}", "#{@user.name}")
      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}/recommendations", 'Препоръки')

      erb :'recommendations.html'
    end

    get '/:id/read' do
      @user = User.find id: params[:id]

      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}", "#{@user.name}")
      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}/read", 'Прочетени Книги')

      erb :'read.html'
    end

    get '/:id/wishlist' do
      @user = User.find id: params[:id]

      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}", "#{@user.name}")
      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}/wishlist", 'Желани Книги')

      erb :'wishlist.html'
    end

    post  '/:id/loan' do
      @user = User.find id: params[:id]
      @copy = Copy.find inventory_number: params[:copy_inventory_number].to_i

      loan_copy(@user, @copy) if @copy && @copy.free?

      redirect "#{NAMESPACE}/#{@user.id}"
    end

    get '/:id/loaned' do
      @user = User.find id: params[:id]

      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}", "#{@user.name}")
      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}/wishlist", 'Невърнати Книги')

      erb :'loaned.html'
    end
  end
end
