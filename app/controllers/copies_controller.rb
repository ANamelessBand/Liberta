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
    @copy = Copy.new(copy_params)
    @copy.print = Print.find params[:print_id]

    if @copy.save
      redirect_back fallback_location: print_path(@copy.print), success: "Копието беше добавено успешно!"
    else
      redirect_to prints_path, warning: "Възникна грешка при добавяне на копиетп!"
    end
  end

  def destroy
    Copy.destroy params[:id]
    redirect_back fallback_location: print_path(params[:print_id]), success: "Копието беше изтрито успешно!"
  end

private

  def copy_params
    params.require(:copy).permit(:inventory_number)
  end
end
