# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :require_admin, only: [:destroy]

  autocomplete :tag, :name, full: true
  add_breadcrumb "Тагове", :tags_path

  def index
    @tags = search_and_paginate(Tag)

    add_breadcrumb("Търсене за: #{params[:search]}", tags_path) unless params[:search].blank?
  end

  def show
    @prints = Print.for_tag(params[:id]).order(:title).page(params[:page])
    @tag = Tag.find params[:id]

    add_breadcrumb @tag.name, tag_path
  end

  def destroy
    tag = Tag.find params[:id]

    if tag.prints.empty?
      tag.destroy!
      redirect_to tags_path, success: "Тагът беше изтрит успешно!"
    else
      redirect_to tags_path, alert: "Грешка: тагът има регистрирани публикации."
    end
  end
end
