# frozen_string_literal: true

class LoansController < ApplicationController
  before_action :require_admin
  before_action :set_and_check_returned, only: [:return, :extend]

  def create
    user = User.find_by email: params[:user]
    copy = Copy.find params[:copy_id]

    loan = Loan.create! user: user,
        copy: copy,
        time_loaned: Time.now,
        time_supposed_return: Time.now + 7.days

    redirect_to print_copy_path(copy.print, copy), success: "Копието беше отдадено успешно!"
  end

  def return
    @loan.return!
    @loan.print.notify_copy_returned!

    redirect_to print_copy_path(@loan.print, @loan.copy), success: "Копието беше върнато успешно!"
  end

  def extend
    @loan.extend!
    redirect_to print_copy_path(@loan.print, @loan.copy), success: "Срокът за връщане беше удължен успешно!"
  end

private

  def set_and_check_returned
    @loan = Loan.find params[:id]

    if @loan.returned?
      redirect_to print_copy_path(@loan.print, @loan.copy), alert: "Грешка: това копие е вече върнато."
    end
  end
end
