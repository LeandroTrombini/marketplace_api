require 'rails_helper'

class Authentication < ApplicationController
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication}

  describe '#current_user' do
    before do
      @user = FactoryBot.create(:user)
      request.headers["Authorization"] = @user.token
      allow(authentication).to receive(:request).and_return(request)
    end

    it 'returns the user from the authorization header' do
      expect(authentication.current_user.token).to eq @user.token
    end
  end

  describe '#authenticate_with_token' do
    context 'when user is not signed in' do
      before do
        allow(authentication).to receive(:user_signed_in?).and_return(false)
      end

      it 'renders a json error message' do
        expect(authentication).to receive(:render).with(json: { errors: 'Not authenticated' }, status: :unauthorized)
        authentication.authenticate_with_token
      end
    end

    context 'when user is signed in' do
      before do
        allow(authentication).to receive(:user_signed_in?).and_return(true)
      end

      it 'does not render an error message' do
        expect(authentication).not_to receive(:render)
        authentication.authenticate_with_token
      end
    end
  end

    describe '#user_signed_in?' do
      context "when there is a user on ' session' " do
        before do
          @user = FactoryBot.create(:user)
          allow(authentication).to receive(:current_user).and_return(@user)
        end
  
        it { should be_user_signed_in }
      end
  
      context "when there is no user on 'session'" do
        before do
          @user = FactoryBot.create(:user)
          allow(authentication).to receive(:current_user).and_return(nil)
        end
  
        it { should_not be_user_signed_in }
      end
    end
end