# frozen_string_literal: true

class UsersController < ApplicationController
  autocomplete :user, :email

  before_action :require_signed_in, only: [:mark_notifications_as_read]
  before_action :set_user, only: [:show, :mark_notifications_as_read]

  add_breadcrumb "Потребители", :users_path

  def index
    @users = helpers.search_and_paginate(User, :email)

    add_breadcrumb("Търсене за: #{params[:search]}", users_path) unless params[:search].blank?
  end

  def show
    add_breadcrumb @user.email, user_path
  end

  def mark_notifications_as_read
    @user.mark_notifications_as_read!
    redirect_back fallback_location: root_path
  end

private

  def set_user
    @user = User.find params[:id]
  end
end
