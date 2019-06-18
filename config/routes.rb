# frozen_string_literal: true

Rails.application.routes.draw do
  root 'hello#index'
  apipie
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  resources :pois
  resources :crawls do
    resources :poi_crawls
  end
end
