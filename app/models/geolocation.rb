class Geolocation < ApplicationRecord
  has_many :notes, dependent: :destroy

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
