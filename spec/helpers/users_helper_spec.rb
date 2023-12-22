# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user, :with_current_employer) }

  describe '#display_username' do
    context 'Username is set' do
      it 'returns username' do
        expected_username = 'James Cameron'
        user.update(username: expected_username)

        expect(display_username(user)).to eq expected_username
      end
    end

    context 'Username is not set' do
      it 'returns default placeholder string; not nil' do
        user.update(username: nil)
        expect(display_username(user)).to_not be_nil
      end
    end
  end

  describe '#display_current_employer_name' do
    context 'Current employer set' do
      it 'returns the current employer name' do
        expect(user.current_employer).to_not be_nil
        expected_name = user.current_employer.name

        expect(display_current_employer_name(user)).to eq expected_name
      end
    end

    context 'Current employer not set' do
      it 'returns the placedholder string; not nil' do
        user.employers.clear

        expect(user.current_employer).to be_nil
        expect(display_current_employer_name(user)).to_not be_nil
        expect(display_current_employer_name(user)).to be_a(String)
      end
    end
  end
end
