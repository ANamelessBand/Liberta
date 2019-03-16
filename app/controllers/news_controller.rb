# frozen_string_literal: true

class NewsController < ApplicationController
  before_action :require_admin

  def create
    News.create! news_params
    redirect_to root_path, success: "Новината беше добавена успешно!"
  end

  def destroy
    News.destroy params[:id]
    redirect_to root_path, success: "Новината беше изтрита успешно!"
  end

private

  def news_params
    params.require(:news).permit(:title, :content)
  end
end
