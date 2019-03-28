# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
    # omniauth_callbacks: "users/omniauth_callbacks"
  }

  get "prints/most-liked", to: "prints#best"
  resources :news, only: [:create, :destroy]

  resources :users, only: [:index, :show] do
    get :autocomplete_user_email, on: :collection
    post :custom_create,          on: :collection

    post :mark_notifications_as_read, on: :member
    post :make_admin,                 on: :member
    post :revoke_admin,               on: :member
    delete :custom_delete,            on: :member
  end

  resources :prints do
    get :autocomplete_print_title, on: :collection
    post :choose_from_api,         on: :collection
    post "add_from_api/:isbn" => "prints#add_from_api", as: :add_from_api, on: :collection

    post :add_wishlist,    on: :member
    post :remove_wishlist, on: :member

    resources :recommendations, only: [:create, :destroy]

    resources :copies, only: [:show, :create, :destroy] do
      resources :loans, only: [:create] do
        post :return, on: :member
        post :extend_loan, on: :member
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

  get :admin, to: "admin#index"

  root to: "home#index"

  # Error handling
  get "/404", to: "errors#not_found"
  get "/422", to: "errors#unacceptable"
  get "/500", to: "errors#internal_error"
end
