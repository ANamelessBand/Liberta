# frozen_string_literal: true

class RecommendationsController < ApplicationController
  before_action :set_print
  before_action :check_delete_permissions, only: [:destroy]

  def create
    recommendation         = Recommendation.new
    recommendation.user    = current_user
    recommendation.print   = @print
    recommendation.rating  = params[:rating].to_f
    recommendation.comment = params[:recommendation][:comment]
    recommendation.save!

    redirect_to print_path(@print), success: "Препоръката беше добавена успешно!"
  end

  def destroy
    Recommendation.destroy params[:id]
    redirect_to print_path(@print), success: "Препоръката беше изтрита успешно!"
  end

private

  def set_print
    @print = Print.find params[:print_id]
  end

  def check_delete_permissions
    deny_access if current_user != Recommendation.find(params[:id]).user && !current_user.admin?
  end
end
