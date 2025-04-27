class Note < ApplicationRecord
  belongs_to :user
  has_one :geolocation, as: :locatable, dependent: :destroy

  # accepts_nested_attributes_for :geolocation, allow_destroy: true
end
