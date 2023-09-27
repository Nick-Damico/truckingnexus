# frozen_string_literal: true

class Quiz < ApplicationRecord
  has_many :questions

  validates :name, presence: true
  validates :name, uniqueness: true
end
