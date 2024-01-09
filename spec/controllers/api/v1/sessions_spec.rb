require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      @user = FactoryBot.create(:user)
    end

    context 'when the credentials are correct' do
      before(:each) do
        credentials = { email: @user.email, password: @user.password }
        post :create, params: { session: credentials }
      end

      it 'returns the user record corresponding to the given credentials' do
        @user.reload
        expect(json_response[:token]).to eq @user.token
      end

      it { should respond_with 200 }
    end

    context 'when the credentials are incorrect' do
      before(:each) do
        credentials = { email: @user.email, password: 'invalid@password' }
        post :create, params: { session: credentials }
      end

      it 'returns a json with an error' do
        expect(json_response[:errors]).to eq 'Invalid email or password'
      end

      it { should respond_with 422 }
    end
  end
end
