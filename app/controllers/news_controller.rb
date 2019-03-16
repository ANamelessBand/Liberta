# frozen_string_literal: true

class NewsController < ApplicationController
  before_action :require_admin

  def create
    news = News.new

    news.title = params[:news][:title]
    news.content = params[:news][:content]
    news.save

    redirect_to root_path, success: "Новината беше добавена успешно!"
  end

  def destroy
    News.destroy params[:id]
    redirect_to root_path, success: "Новината беше изтрита успешно!"
  end
end
