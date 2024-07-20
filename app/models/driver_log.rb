# frozen_string_literal: true

class DriverLog < ApplicationRecord
  belongs_to :driver, class_name: 'User'
  has_many :duty_statuses
end
