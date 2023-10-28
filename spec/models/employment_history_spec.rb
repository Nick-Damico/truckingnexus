# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmploymentHistory, type: :model do
  it { belong_to(:employee) }
end
