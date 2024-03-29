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
    resources :crawl_users
  end
  resources :friendships do
    get 'waiting', on: :collection
  end
  resources :comment_threads do
    resources :comments
  end
end
