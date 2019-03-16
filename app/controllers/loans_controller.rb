# frozen_string_literal: true

class LoansController < ApplicationController
  before_action :require_admin

  def create
    user = User.find_by email: params[:user]
    copy = Copy.find params[:copy_id]

    loan = Loan.new
    loan.user = user
    loan.copy = copy
    loan.time_loaned = Time.now
    loan.time_supposed_return = Time.now + 7.days
    loan.save!

    redirect_to print_copy_path(copy.print, copy), success: "Копието беше отдадено успешно!"
  end

  def return
    loan = Loan.find params[:id]

    if loan.time_returned
      redirect_to print_copy_path(loan.copy.print, loan.copy), alert: "Грешка: това копие е вече върнато."
    end

    loan.time_returned = Time.now
    loan.save!

    redirect_to print_copy_path(loan.copy.print, loan.copy), success: "Копието беше върнато успешно!"
  end

  def extend
    loan = Loan.find params[:id]

    if loan.time_returned
      redirect_to print_copy_path(loan.copy.print, loan.copy), alert: "Това копие е вече върнато"
    end

    loan.time_supposed_return += 7.days
    loan.save!

    redirect_to print_copy_path(loan.copy.print, loan.copy), success: "Срокът за връщане беше удължен успешно!"
  end
end
