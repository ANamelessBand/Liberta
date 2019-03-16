# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :require_admin, only: [:destroy]

  autocomplete :tag, :name
  add_breadcrumb "Тагове", :tags_path

  def index
    @tags = helpers.search_and_paginate(Tag)

    add_breadcrumb("Търсене за: #{params[:search]}", tags_path) unless params[:search].blank?
  end

  def show
    @prints = Print.joins(:tags)
        .where("tags.id == :id", id: params[:id])
        .order(:title)
        .page(params[:page])

    @tag = Tag.find params[:id]

    add_breadcrumb @tag.name, tag_path
  end

  def destroy
    tag = Tag.find params[:id]
    unless tag.prints.empty?
      redirect_to tags_path, alert: "Грешка: тагът има регистрирани публикации."
    else
      tag.destroy!
      redirect_to tags_path, success: "Тагът беше изтрит успешно!"
    end
  end
end
