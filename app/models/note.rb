class Note < ApplicationRecord
  belongs_to :user

  # accepts_nested_attributes_for :geolocation, allow_destroy: true
end
