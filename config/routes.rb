# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: "manager/sessions" }

  namespace :manager do
    root "rooms#index"

    resources :rooms
    resources :locations
    resources :favorite_spaces
    resources :admins
    resources :prices
    resources :utilities
  end
end
