# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'tests#index'

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
end
