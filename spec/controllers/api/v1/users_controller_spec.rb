# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET /index' do
    before(:each) do
      @user = FactoryBot.create :user
      @user2 = FactoryBot.create :user
      get :index
    end

    it 'returns the information about a report on a hash' do
      user_response = json_response
      expect(user_response.count).to eq 2
    end

    it { should respond_with :ok }
  end

  describe 'GET #show' do
    before(:each) do
      @user = FactoryBot.create :user
      get :show, params: { id: @user.id }
    end

    it 'returns the information about a report on a hash' do
      user_response = json_response
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
        user_response = json_response
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
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        user_response = json_response
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
      end

      it 'renders the json representation for the updated user' do
        user_response = json_response

        expect(user_response[:email]).to eq 'newemail@email.com'
      end

      it { should respond_with 200 }     
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
        user_response = json_response
        
        expect(user_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not to be updated' do
        user_response = json_response
        
        expect(user_response[:errors][:email]).to include 'is invalid'
      end

      it { should respond_with 422 }
    end    
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @user = FactoryBot.create(:user)
      allow(User).to receive(:find).and_return(@user)
    end
  
    context 'when the user is successfully destroyed' do
      before(:each) do
        allow(@user).to receive(:destroy).and_return(true)
        delete :destroy, params: { id: @user.id }, format: :json
      end
  
      it { should respond_with 204 }
    end
  
    context 'when the user is not destroyed' do
      before(:each) do
        allow(@user).to receive(:destroy).and_return(false)
        delete :destroy, params: { id: @user.id }, format: :json
      end
  
      it 'renders an errors json' do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
  
      it 'renders the json errors on why the user could not be destroyed' do
        user_response = json_response
      
        expect(user_response[:errors]).to include('It was not possible to delete the user.')
      end
  
      it { should respond_with 422 }
    end
  end
end
