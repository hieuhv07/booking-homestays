# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  devise_for :admins, controllers: { sessions: "manager/sessions" }
  resources :trends
  resources :rooms

  namespace :manager do
    root "admins#index"

    resources :rooms do
      resources :prices
    end
    resources :favorite_spaces
    resources :admins
    resources :members
    resources :prices

    resources :locations do
      resources :areas, only: %i[new create]
    end
    resources :areas, except: %i[new create] do
      resources :addresses, only: %i[new create]
    end
    resources :addresses, except: %i[new create]
    resources :trends do
      patch :convert_status, on: :member
    end
    resources :utilities
  end
end
