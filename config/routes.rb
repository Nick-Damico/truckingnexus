# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'static_pages#home'

  resources :users, only: %i[show update]

  # QUIZ ROUTES
  resources :answer_sheet_questions, only: %i[edit update]
  resources :companies, only: %i[index show] do
    resources :reviews, only: %i[index show new create edit destroy], module: :companies
  end
  resources :quizzes, only: [:index]
  resources :user_quizzes, only: %i[index new create show destroy]
  namespace :user_quizzes do
    resources :results, only: %i[show]
  end
end
