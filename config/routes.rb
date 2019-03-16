# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get "prints/most-liked", to: "prints#best"
  resources :news, only: [:create, :destroy]

  resources :users, only: [:index, :show] do
    get :autocomplete_user_email, on: :collection

    post :mark_notifications_as_read, on: :member
  end

  resources :prints do
    get :autocomplete_print_title, on: :collection

    post :add_wishlist, on: :member
    post :remove_wishlist, on: :member

    resources :recommendations, only: [:create, :destroy]

    resources :copies, only: [:show, :create, :destroy] do
      resources :loans, only: [:create] do
        get :return, on: :member
        get :extend, on: :member
      end
    end
  end

  resources :authors, only: [:index, :show, :destroy] do
    get :autocomplete_author_name, on: :collection
  end

  resources :publishers, only: [:index, :show, :destroy] do
    get :autocomplete_publisher_name, on: :collection
  end

  resources :tags, only: [:index, :show, :destroy] do
    get :autocomplete_tag_name, on: :collection
  end

  root to: "home#index"
end
