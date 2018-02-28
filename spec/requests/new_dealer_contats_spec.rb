require 'rails_helper'

RSpec.describe "NewDealerContats", type: :request do
  describe "GET /new_dealer_contats" do
    it "works! (now write some real specs)" do
      get new_dealer_contats_path
      expect(response).to have_http_status(200)
    end
  end
end
