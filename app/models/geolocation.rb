class Geolocation < ApplicationRecord
  belongs_to :locatable, polymorphic: true

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :locatable, presence: true
end
