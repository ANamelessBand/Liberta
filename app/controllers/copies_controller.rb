# frozen_string_literal: true

class CopiesController < ApplicationController
  before_action :require_admin, except: [:show]

  def show
    @copy = Copy.find params[:id]

    add_breadcrumb "Библиотека", prints_path
    add_breadcrumb @copy.print.title, print_path(@copy.print)
    add_breadcrumb "Копие: #{@copy.inventory_number}", print_copy_path
  end

  def create
    copy = Copy.new

    copy.inventory_number = params[:copy][:inventory_number]

    print = Print.find params[:print_id]

    copy.print = print

    if copy.save
      redirect_to print_path(print), success: "Копието беше добавено успешно!"
    else
      redirect_to prints_path(print), warning: "Възникна грешка при добавяне на копиетп!"
    end
  end

  def destroy
    Copy.destroy params[:id]
    redirect_to print_path(params[:print_id]), success: "Копието беше изтрито успешно!"
  end
end
