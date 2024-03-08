# frozen_string_literal: true

class Company < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :users

  has_many :employment_histories, foreign_key: :employer_id
  has_many :employees, through: :employment_histories

  has_many :reviews, as: :reviewable

  def rating
    Review.rating_for(self)
  end

  def reviewed_by(reviewer)
    reviews.exists?(reviewer:)
  end
end
