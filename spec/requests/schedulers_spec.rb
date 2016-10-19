require 'rails_helper'

RSpec.describe "Schedulers", type: :request do
  describe "GET /schedulers" do
    it "works! (now write some real specs)" do
      get schedulers_path
      expect(response).to have_http_status(200)
    end
  end
end
