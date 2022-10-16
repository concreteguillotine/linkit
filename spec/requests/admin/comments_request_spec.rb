require 'rails_helper'

RSpec.describe "Admin::Comments", type: :request do
  xdescribe "GET /delete" do
    it "returns http success" do
      get "/admin/comments/delete"
      expect(response).to have_http_status(:success)
    end
  end
end
