require "rails_helper"

RSpec.describe Geolocation, type: :model do
  it { should have_many(:notes) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
end
