# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each) do
    request.headers['Accept'] = 'application/vnd.marketplace.v1'
  end

  describe 'GET /index' do
    before(:each) do
      @user = FactoryBot.create :user
      get :show, params: { id: @user.id }, format: :json
    end

    it 'returns the information about a report on a hash' do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eq @user.email
    end

    it { should respond_with :ok }
  end

  describe 'POST #create' do
    context 'when is succesfully created' do
      before(:each) do
        @user_attributes = FactoryBot.attributes_for :user
        post :create, params: { user: @user_attributes }, format: :json
      end

      it 'renders the json representation for the user record just created' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eq @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context 'when is not succesfully created' do
      before(:each) do
        @invalid_user_attributes = {
          password: '123456',
          password_confirmation: '123456'
        }
        post :create, params: { user: @invalid_user_attributes }, format: :json
      end

      it 'renders an error json' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe 'PUT/PATCH #update' do        
    context 'when is successfuly updated' do
      before(:each) do
        @user = FactoryBot.create(:user)
        patch :update, params: {
          id: @user.id,
          user: { email: 'newemail@email.com' }, format: :json
        }

        it 'renders the json representation for the updated user' do
          user_response = JSON.parse(response.body, symbolize_names: true)

          expect(user_response[:email]).to eq 'newemail@email.com'
        end

        it { should response_with 200 }
      end
    end

    context 'when is not upgdates' do
      before(:each) do
        @user = FactoryBot.create(:user)
        patch :update, params: {
          id: @user.id,
          user: { email: 'bademail.com' }, format: :json
        }
      end

      it 'renders an errors json' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        
        expect(user_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not to be updated' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        
        expect(user_response[:errors][:email]).to include 'is invalid'
      end

      it { should respond_with 422 }
    end    
  end
end
