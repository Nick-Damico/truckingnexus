# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'static_pages#home'

  # User registartion handled by RegistrationsController
  devise_for :users, controllers: { registrations: :registrations }
  resources :users, only: %i[show update]

  # QUIZ ROUTES
  resources :answer_sheet_questions, only: %i[edit update]
  resources :companies, only: %i[index show] do
    resources :reviews, module: :companies
  end
  resources :quizzes, only: [:index]
  resources :user_quizzes, only: %i[index new create show destroy]
  namespace :user_quizzes do
    resources :results, only: %i[show]
  end
end
