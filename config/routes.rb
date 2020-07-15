# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'tests#index'

  namespace :admin do
    root 'tests#index'

    resources :tests do
      resources :questions, except: :index, shallow: true do
        resources :answers, except: %i[index show], shallow: true
      end
    end
  end

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :statistics, only: %i[show update] do
    member do
      get :result
    end
  end
end
