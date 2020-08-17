# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root 'tests#index'

  namespace :admin do
    root 'tests#index'

    resources :tests do
      resources :questions, except: :index, shallow: true do
        resources :answers, except: %i[index show], shallow: true
      end

      member do
        patch :update_inline
      end
    end

    resources :gists, only: %i[index destroy]
  end

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :statistics, only: %i[show update] do
    member do
      get :result
      post :create_gist
    end
  end

  resources :feedbacks, only: %i[create]
end
