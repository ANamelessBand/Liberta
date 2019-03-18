# frozen_string_literal: true

class UsersController < ApplicationController
  autocomplete :user, :email, full: true

  before_action :require_signed_in, only: [:mark_notifications_as_read]
  before_action :require_admin, only: [:make_admin, :revoke_admin, :custom_create, :custom_delete]

  before_action :set_user, only: [:show, :mark_notifications_as_read, :make_admin, :revoke_admin]

  add_breadcrumb "Потребители", :users_path

  def index
    @users = search_and_paginate(User, :email)

    add_breadcrumb("Търсене за: #{params[:search]}", users_path) unless params[:search].blank?
  end

  def show
    breadcrumb_name = @user == current_user ? "Моите книги" : "Книгите на #{@user.email}"
    add_breadcrumb breadcrumb_name, user_path
  end

  def mark_notifications_as_read
    @user.mark_notifications_as_read!
    redirect_back fallback_location: root_path
  end

  def make_admin
    @user.admin = true
    @user.save!

    redirect_back fallback_location: root_path
  end

  def revoke_admin
    @user.admin = false
    @user.save!

    redirect_back fallback_location: root_path
  end

  def custom_create
    password = Faker::Internet.password
    @user = User.new email: params[:email],
        password: password,
        password_confirmation: password

    if @user.save!
      redirect_back fallback_location: users_path, success: "Потребителят беше създаден успешно!"
    else
      redirect_back fallback_location: users_path, warning: "Възникна грешка при създаване на потребителя!"
    end
  end

  def custom_delete
    User.destroy params[:id]

    redirect_back fallback_location: users_path, success: "Потребителят беше изтрит успешно!"
  end
private

  def set_user
    @user = User.find params[:id]
  end
end
