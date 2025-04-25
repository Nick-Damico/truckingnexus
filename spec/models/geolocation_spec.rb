require "rails_helper"

RSpec.describe Geolocation, type: :model do
  it { should belong_to(:locatable) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:locatable) }
end
