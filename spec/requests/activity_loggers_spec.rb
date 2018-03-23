require 'rails_helper'

RSpec.describe "ActivityLoggers", type: :request do
  describe "GET /activity_loggers" do
    it "works! (now write some real specs)" do
      get activity_loggers_path
      expect(response).to have_http_status(200)
    end
  end
end
