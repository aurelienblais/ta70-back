# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
end
