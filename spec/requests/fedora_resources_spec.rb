require 'rails_helper'

RSpec.describe "FedoraResources", type: :request do
  describe "GET /fedora_resources" do
    it "works! (now write some real specs)" do
      get fedora_resources_path
      expect(response).to have_http_status(200)
    end
  end
end
