# frozen_string_literal: true

class Company < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :users
  has_many :employment_histories, foreign_key: :employer_id
  has_many :employees, through: :employment_histories
end
