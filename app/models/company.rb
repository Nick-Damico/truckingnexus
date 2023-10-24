# frozen_string_literal: true

class Company < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :users
end
