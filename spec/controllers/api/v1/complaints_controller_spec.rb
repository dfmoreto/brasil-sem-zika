require 'rails_helper'

RSpec.describe Api::V1::ComplaintsController, type: :controller do
  before(:each) do
    @user = create :user
    @user.generate_authentication_token!
    include_default_accept_headers
    api_authorization_header @user.auth_token
  end

  describe "GET #show" do
    let(:complaint) { create :complaint }

    before(:each) do
      get :show, id: complaint.id
    end

    it "returns the information about a complaint on a hash" do
      complaint_response = json_response[:complaint]
      expect(complaint_response[:address]).to eq complaint.address
    end

    it { is_expected.to respond_with 200 }

  end

  describe "GET #index" do
    let!(:complaints) { create_list :complaint, 4 }

    before(:each) do
      get :index
    end

    it "returns 4 records from the database" do
      complaint_response = json_response
      expect(complaint_response[:complaints]).to have(4).items
    end

    it { is_expected.to respond_with 200 }
  end
end
