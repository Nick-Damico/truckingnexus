# frozen_string_literal: true

Rails.application.routes.draw do
  get 'driver_logs/index'
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

  resources :driver_logs, only: %i[index]

  resources :quizzes, only: %i[index new create edit show] do
    resources :questions, except: %i[destroy]
  end

  resources :user_quizzes, only: %i[index create show destroy]
  namespace :user_quizzes do
    resources :results, only: %i[show]
  end
end
