# frozen_string_literal: true

class DriverLog < ApplicationRecord
  belongs_to :driver, class_name: 'User'
end
