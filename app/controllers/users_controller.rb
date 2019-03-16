# frozen_string_literal: true

class UsersController < ApplicationController
  autocomplete :user, :email

  add_breadcrumb "Потребители", :users_path

  def index
    @users = helpers.search_and_paginate(User)

    add_breadcrumb("Търсене за: #{params[:search]}", users_path) unless params[:search].blank?
  end

  def show
    @user = User.find params[:id]

    add_breadcrumb @user.email, user_path
  end
end
