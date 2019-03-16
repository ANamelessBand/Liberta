# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @last_news   = News.order(created_at: :desc).last(10)
    @last_prints = Print.order(created_at: :desc).last(10)
  end
end
