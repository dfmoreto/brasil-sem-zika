require 'rails_helper'

describe Api::V1::SessionsController, api: true do
  describe "POST #create" do
    let!(:user) { create :user }

    context "when the credentials are correct" do
      before(:each) do
        credentials = { email: user.email, password: user.password }
        post :create, session: credentials
      end

      it "returns the user record corresponding to the given credentials" do
        user.reload
        expect(json_response[:auth_token]).to eq user.auth_token
      end

      it { should respond_with 200 }
    end

    context "when credentials are incorrect" do
      before(:each) do
        credentials = { email: user.email, password: 'invalidpassword' }
        post :create, session: credentials
      end

      it "returns a json with an error" do
        expect(json_response[:errors]).to eq "Invalid email or password"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create :user
      sign_in @user
      delete :destroy, id: @user.auth_token
    end

    it { should respond_with 204 }
  end

end
