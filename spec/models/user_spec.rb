# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:quizzes).through(:user_quizzes) }
  it { should have_many(:employers).through(:employment_histories) }

  describe '#current_employer' do
    it 'returns the users current employer' do
      user = create(:user, :with_current_employer)
      expected_employer = user.employment_histories.find_by(current: true)&.employer

      expect(user.current_employer).to eq expected_employer
      expect(user.current_employer).to_not be_nil
    end
  end
end
