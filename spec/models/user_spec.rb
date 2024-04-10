# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it { should have_many(:authored_quizzes) }
  it { should have_many(:quizzes).through(:user_quizzes) }
  it { should have_many(:employers).through(:employment_histories) }
  it { should have_many(:reviews) }
  it { should have_one_attached(:avatar) }

  describe '#current_employer' do
    it 'returns the users current employer' do
      user = create(:user, :with_current_employer)
      expected_employer = user.employment_histories.find_by(current: true)&.employer

      expect(user.current_employer).to eq expected_employer
      expect(user.current_employer).to_not be_nil
    end
  end

  describe 'avatar attachables' do
    it 'generates a :thumb variant' do
      subject.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'default-avatar01.png')),
        filename: 'default-avatar01.png',
        content_type: 'images/png'
      )

      subject.save!

      expect(subject.avatar.variant(:thumb)).to be_a(ActiveStorage::VariantWithRecord)
    end
  end
end
