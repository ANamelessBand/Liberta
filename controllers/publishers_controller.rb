module Liberta
  class PublishersController < ApplicationController
    NAMESPACE = '/publishers'.freeze

    before do
      @breadcrumbs << NavigationLink.new(0, NAMESPACE, 'Издателства')
      set_active_navigation_link(NavigationLink.prints_id)
    end

    get '/' do
      redirect Liberta::PrintsController::NAMESPACE
    end

    before '/:id*' do
      @publisher = Publisher.find id: params[:id]
      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}", @publisher.name)

      @id = @publisher.id
    end

    get '/:id' do
      @title      = "Публикации от #{@publisher.name}"
      @top_prints = @publisher.top_prints.take SEARCH_RESULTS_PER_PAGE

      erb :'prints_by.html', locals: {show_all: false}
    end

    get '/:id/all' do
      @breadcrumbs << NavigationLink.new(0, "#{NAMESPACE}/#{params[:id]}/all", 'Всички публикации')

      @title      = "Всички публикации от #{@publisher.name}"
      @top_prints = @publisher.top_prints

      erb :'prints_by.html', locals: {show_all: true}
    end
  end
end
