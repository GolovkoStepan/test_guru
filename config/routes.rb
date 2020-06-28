# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tests do
    resources :questions, except: :index, shallow: true do
      resources :answers, except: %i[index show], shallow: true
    end
  end
end
