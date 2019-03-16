# frozen_string_literal: true

class WishlistsController < ApplicationController
  def create
    @print = Print.find params[:print_id]
    Wishlist.create!(user: current_user, print: @print)

    redirect_to print_path(@print)
  end

  def destroy
    wishlist = Wishlist.find params[:id]
    wishlist.destroy! if wishlist.user == current_user

    redirect_to print_path(params[:print_id])
  end
end
