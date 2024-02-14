require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe "GET /index" do
     before(:each) do
      current_user = FactoryBot.create(:user)
      api_authorization_header(current_user.token)
      FactoryBot.create_list(:order, 4, user: current_user)
      get :index, params: { user_id: current_user.id }
    end

    it 'retunrs 4 orders records from the user' do
      orders_response = json_response[:orders]
      expect(orders_response.size).to eq(4)
    end

    it { should respond_with 200 }
  end
end
