# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: "manager/sessions" }

  namespace :manager do
    root "admins#index"

    resources :rooms
    resources :favorite_spaces
    resources :admins
    resources :prices

    resources :locations do
      resources :areas, except: %i[destroy edit update]
    end

    resources :areas, only: %i[edit update destroy] do
      resources :addresses, except: %i[destroy edit update]
    end

    resources :addresses, only: %i[destroy edit update]
  end
end
