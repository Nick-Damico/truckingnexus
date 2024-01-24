# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#button_size_class' do
    context 'with supplied size' do
      it 'returns the button class for the specified size' do
        expect(button_size_class(:small)).to_not be_nil
        expect(button_size_class(:small)).to be_a(String)
      end
    end

    context 'without supplied size' do
      it 'returns the default button class' do
        expect(button_size_class).to_not be_nil
        expect(button_size_class).to be_a(String)
      end
    end
  end
end
