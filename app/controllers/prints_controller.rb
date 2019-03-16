# frozen_string_literal: true

class PrintsController < ApplicationController
  before_action :set_print,         only: [:show, :edit, :update, :destroy, :add_wishlist, :remove_wishlist]
  before_action :require_admin,     only: [:new, :create, :edit, :update, :destroy]
  before_action :require_signed_in, only: [:add_wishlist, :remove_wishlist]

  autocomplete :print, :title
  add_breadcrumb "Библиотека", :prints_path

  def index
    @prints = helpers.search_and_paginate(Print, :title)

    add_breadcrumb("Търсене за: #{params[:search]}", prints_path) unless params[:search].blank?
  end

  def best
    @prints = Print.best.take(10)

    add_breadcrumb "Топ 10", prints_most_liked_path
  end

  def show
    add_breadcrumb @print.title, print_path
  end

  def add_wishlist
    Wishlist.create!(user: current_user, print: @print)
  end

  def remove_wishlist
    w = Wishlist.find_by_user_id_and_print_id current_user.id, params[:id]
    w.destroy!
  end

  ## Admin operations

  def new
    @print = Print.new

    add_breadcrumb "Нова публикация", :new_print_path
  end

  def create
    @print = Print.new(print_params)
    set_print_associations(@print)

    if @print.save
      redirect_to prints_path, notice: "Публикацията беше запазена успешно!"
    else
      render :new
    end
  end

  def edit
    add_breadcrumb "Редактиране на #{@print.title}", :edit_print_path
  end

  def update
    @print.update_attributes print_params
    set_print_associations(@print)

    if @print.save
      redirect_to print_path(@print), notice: "Публикацията беше редактирана успешно!"
    else
      render :edit
    end
  end

  def destroy
    @print.destroy!
    redirect_to prints_path, success: "Публикацията беше изтрита успешно! "
  end

private

  def set_print
    @print = Print.find params[:id]
  end

  def print_params
    params.require(:print).permit(:title, :language, :format, :description, :isbn, :pages, :cover_url)
  end

  def set_print_associations(print)
    authors = params[:authors_names]
    publisher = params[:publisher_name]
    tags = params[:tags]

    print.publisher = Publisher.find_or_create_by name: publisher
    print.authors = authors.split(",").filter(&:present?).map { |name| Author.find_or_create_by name: name.strip }
    print.tags = tags.split(",").filter(&:present?).map! { |name| Tag.find_or_create_by name: name.strip }
  end
end
