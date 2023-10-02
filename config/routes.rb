# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'static_pages#home'

  resources :companies, only: [:index]
  resources :quizzes, only: [:index]
  resources :user_quizzes, only: %i[new create show]
  resources :answer_sheet_questions, only: %i[edit update]
end
