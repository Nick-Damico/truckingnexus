# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'static_pages#home'

  resources :answer_sheet_questions, only: %i[edit update]
  resources :companies, only: [:index]
  resources :quizzes, only: [:index]
  resources :user_quizzes, only: %i[new create show destroy]
  resources :users, only: %i[show update]
end
