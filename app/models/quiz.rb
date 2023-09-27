# frozen_string_literal: true

class Quiz < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
end
