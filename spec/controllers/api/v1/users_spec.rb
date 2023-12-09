require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  before(:each) do
    request.headers['Accept'] = 'application/vnd.marketplace.v1' 
  end

  describe "GET /index" do
    before(:each) do
      @user = FactoryBot.create :user
      get :show , params: { id: @user.id }, format: :json
    end

    it 'returns the information about a report on a hash' do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eq @user.email
    end

    it { should respond_with :ok }
  end
end
