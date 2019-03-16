# frozen_string_literal: true

class UsersController < ApplicationController
  autocomplete :user, :email

  before_action :require_signed_in, only: [:mark_notifications_as_read]
  before_action :require_admin, only: [:make_admin, :revoke_admin]

  before_action :set_user, only: [:show, :mark_notifications_as_read, :make_admin, :revoke_admin]

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

private

  def set_user
    @user = User.find params[:id]
  end
end
