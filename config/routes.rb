# frozen_string_literal: true

Rails.application.routes.draw do
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  delete '/sign_out', to: 'sessions#destroy'

  resources :users, only: :create
  resources :sessions, only: :create

  resources :tests do
    resources :questions, except: :index, shallow: true do
      resources :answers, except: %i[index show], shallow: true
    end

    member do
      post :start
    end
  end

  resources :statistics, only: %i[show update] do
    member do
      get :result
    end
  end

  root 'tests#index'
end
