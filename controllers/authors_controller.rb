module Liberta
  class AuthorsController < ApplicationController
    NAMESPACE = '/authors'.freeze

    before do
      @breadcrumbs << NavigationLink.new(0, NAMESPACE, 'Автори')
      set_active_navigation_link(NavigationLink.prints_id)
    end

    get '/' do
      redirect Liberta::PrintsController::NAMESPACE
    end

    before '/:id*' do
      @author = Author.find id: params[:id]
      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}", @author.name)

      @id = @author.id
    end

    get '/:id' do
      @title      = "Публикации от #{@author.name}"
      @top_prints = @author.top_prints.take SEARCH_RESULTS_PER_PAGE

      erb :'prints_by.html', locals: {show_all: false}
    end

    get '/:id/all' do
      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}/all", 'Всички публикации')

      @title      = "Всички публикации от #{@author.name}"
      @top_prints = @author.top_prints

      erb :'prints_by.html', locals: {show_all: true}
    end
  end
end
