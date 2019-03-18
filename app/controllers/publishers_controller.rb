# frozen_string_literal: true

class PublishersController < ApplicationController
  before_action :require_admin, only: [:destroy]

  autocomplete :publisher, :name, full: true
  add_breadcrumb "Издателства", :publishers_path

  def index
    @publishers = search_and_paginate(Publisher)

    add_breadcrumb("Търсене за: #{params[:search]}", publishers_path) unless params[:search].blank?
  end

  def show
    @prints = Print.for_publisher(params[:id]).order(:title).page(params[:page])
    @publisher = Publisher.find params[:id]

    add_breadcrumb @publisher.name, publisher_path
  end

  def destroy
    publisher = Publisher.find params[:id]

    if publisher.prints.empty?
      publisher.destroy!
      redirect_to publishers_path, success: "Издателството беше изтрито успешно!"
    else
      redirect_to publishers_path, alert: "Грешка: издателството има регистрирани публикации."
    end
  end
end
