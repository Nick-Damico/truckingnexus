# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company, optional: true

  has_many :user_quizzes
  has_many :quizzes, through: :user_quizzes

  has_many :employment_histories, foreign_key: :employee_id
  has_many :employers, through: :employment_histories

  has_many :reviews, foreign_key: :reviewer_id

  accepts_nested_attributes_for :employment_histories

  def current_employer
    employment_histories.find_by(current: true)&.employer
  end
end
