class AddRefLocatableToGeolocations < ActiveRecord::Migration[7.2]
  def change
    # This will add a locatable_id and locatable_type column to the geolocations table.
    add_reference :geolocations, :locatable, polymorphic: true, index: true
  end
end
