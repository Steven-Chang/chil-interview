# frozen_string_literal: true

Rails.application.routes.draw do
  get "tags/show"
  root "posts#index"

  get "/login", to: "login#new"
  post "/login", to: "login#create"
  delete "/logout", to: "login#destroy"

  resources :comments, only: :create, defaults: { format: :js }
  resources :posts, except: :index
  resources :tags, param: :name, only: :show

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
    	resources :comments, only: :create
    end
  end
end
