# frozen_string_literal: true

Rails.application.routes.draw do
  get 'tags/show'
  root "posts#index"

  get "/login", to: "login#new"
  post "/login", to: "login#create"
  delete "/logout", to: "login#destroy"

  resources :posts, except: :index
  resources :tags, param: :name, only: :show
end
