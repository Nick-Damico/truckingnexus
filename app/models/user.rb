# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company, optional: true

  has_many :user_quizzes
  has_many :quizzes, through: :user_quizzes

  has_many :employment_histories
  has_many :employers, through: :employment_histories, source: :employer
end
