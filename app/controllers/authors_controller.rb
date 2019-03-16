# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :require_admin, only: [:destroy]

  autocomplete :author, :name
  add_breadcrumb "Автори", :authors_path

  def index
    @authors = helpers.search_and_paginate(Author)

    add_breadcrumb("Търсене за: #{params[:search]}", authors_path) unless params[:search].blank?
  end

  def show
    @prints = Print.joins(:authors)
        .where("authors.id == :id", id: params[:id])
        .order(:title)
        .page(params[:page])

    @author = Author.find params[:id]

    add_breadcrumb @author.name, author_path
  end

  def destroy
    author = Author.find params[:id]
    unless author.prints.empty?
      redirect_to authors_path, alert: "Грешка: авторът има регистрирани публикации."
    else
      author.destroy!
      redirect_to authors_path, success: "Авторът беше изтрит успешно!"
    end
  end
end
