# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:quizzes).through(:user_quizzes) }
  it { should have_many(:employers).through(:employment_histories) }
end
