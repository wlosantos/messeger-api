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

  describe "GET /show" do
    context "successfully" do
      it "returns status code success" do
        app = create(:app)
        get(api_v1_app_path(app), params: {}, headers:)
        expect(response).to have_http_status(:success)
      end

      it "returns a app" do
        app = create(:app)
        get(api_v1_app_path(app), params: {}, headers:)
        expect(json_body[:data][:attributes][:name]).to eq(app.name)
      end
    end

    context "when the app does not exist" do
      it "returns status code 404" do
        get(api_v1_app_path(0), params: {}, headers:)
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /create" do
    context "when the parameters are valid" do
      it "returns status code 201" do
        app = build(:app)
        post(api_v1_apps_path, params: { app: app.attributes }.to_json, headers:)
        expect(response).to have_http_status(201)
      end

      it "returns the json for created app" do
        app = build(:app)
        post(api_v1_apps_path, params: { app: app.attributes }.to_json, headers:)
        expect(json_body[:data][:attributes][:name]).to eq(app.name)
      end
    end

    context "when the parameters are invalid" do
      it "returns status code 422" do
        app = build(:app, name: nil)
        post(api_v1_apps_path, params: { app: app.attributes }.to_json, headers:)
        expect(response).to have_http_status(422)
      end

      it "returns the json error for name" do
        app = build(:app, name: nil)
        post(api_v1_apps_path, params: { app: app.attributes }.to_json, headers:)
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end
end
