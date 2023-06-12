require 'rails_helper'

RSpec.describe App, type: :model do
  describe "database" do
    context "must be present" do
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:app_id).of_type(:integer).with_options(null: false) }
    end

    context "indexes" do
      it { is_expected.to have_db_index(:app_id).unique }
    end
  end

  describe "validations" do
    context "presence" do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:app_id) }
    end

    context "uniqueness" do
      subject { FactoryBot.create(:app) }
      it { is_expected.to validate_uniqueness_of(:app_id).ignoring_case_sensitivity }
    end
  end

  describe "create app" do
    context "successfully" do
      subject { create(:app) }
      it { is_expected.to be_valid }
    end

    context "failure - without name" do
      subject { build(:app, name: nil) }
      it { is_expected.to_not be_valid }
    end

    context "failure - without app_id" do
      subject { build(:app, app_id: nil) }
      it { is_expected.to_not be_valid }
    end

    context "failure - duplicate app_id" do
      let!(:app) { create(:app) }
      let(:app2) { build(:app, app_id: app.id) }
      before { app2.valid? }
      it { is_expected.to_not be_valid }
    end
  end
end
