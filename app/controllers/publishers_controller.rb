# frozen_string_literal: true

class PublishersController < ApplicationController
  before_action :require_admin, only: [:destroy]

  autocomplete :publisher, :name
  add_breadcrumb "Издателства", :publishers_path

  def index
    @publishers = helpers.search_and_paginate(Publisher)

    add_breadcrumb("Търсене за: #{params[:search]}", publishers_path) unless params[:search].blank?
  end

  def show
    @prints = Print.where("publisher_id == :id", id: params[:id])
        .order(:title)
        .page(params[:page])

    @publisher = Publisher.find params[:id]

    add_breadcrumb @publisher.name, publisher_path
  end

  def destroy
    publisher = Publisher.find params[:id]
    unless publisher.prints.empty?
      redirect_to publishers_path, alert: "Грешка: издателството има регистрирани публикации."
    else
      publisher.destroy!
      redirect_to publishers_path, success: "Издателството беше изтрито успешно!"
    end
  end
end
