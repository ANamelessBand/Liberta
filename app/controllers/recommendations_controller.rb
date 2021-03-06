# frozen_string_literal: true

class RecommendationsController < ApplicationController
  before_action :require_signed_in
  before_action :set_print

  def create
    Recommendation.create! user: current_user,
        print: @print,
        rating: params[:rating].to_f,
        comment: params[:recommendation][:comment]

    redirect_back fallback_location: print_path(@print), success: "Препоръката беше добавена успешно!"
  end

  def destroy
    if current_user != Recommendation.find(params[:id]).user && !current_user.admin?
      deny_access
      return
    end

    Recommendation.destroy params[:id]
    redirect_back fallback_location: print_path(@print), success: "Препоръката беше изтрита успешно!"
  end

private

  def set_print
    @print = Print.find params[:print_id]
  end
end
