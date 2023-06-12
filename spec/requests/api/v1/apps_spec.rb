require 'rails_helper'

RSpec.describe "Api::V1::Apps", type: :request do
  before { host! "messeger-fractal.com.br" }
  let(:headers) do
    {
      "Accept" => "application/vnd.messeger-fractal.v1",
      "Content-Type" => Mime[:json].to_s
    }
  end

  describe "GET /index" do
    let!(:apps) { create_list(:app, 5) }
    before { get "/api/apps", params: {}, headers: }

    context "successfully" do
      it "returns status code success" do
        expect(response).to have_http_status(:success)
      end

      it "returns a list of apps" do
        expect(json_body[:data].count).to eq(5)
      end
    end
  end
end
