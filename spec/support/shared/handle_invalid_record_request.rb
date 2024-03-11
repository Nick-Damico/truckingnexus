# frozen_string_literal: true

RSpec.shared_examples 'handles invalid resource request' do |resource_name|
  let(:invalid_id) { return 'bad_id' }

  describe "Get /#{resource_name}/:id}" do
    it 'handles a missing record gracefully by redirecting to root_url' do
      get send("#{resource_name}_url", invalid_id)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(:root)
    end
  end
end
