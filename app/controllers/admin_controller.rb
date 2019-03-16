class AdminController < ApplicationController
  before_action :require_admin

  add_breadcrumb "Администрация", :admin_path

  def index
    @wishlists = Wishlist.all
    @overdue = Copy.all.filter { |copy| copy.taken? && copy.current_loan.overdue? }
  end
end
