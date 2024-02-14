# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  subject { user }

  describe 'When respond to email and password' do
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:token) }
  end

  describe 'When email is present' do
    it { should be_valid }
  end

  describe 'When email is not present' do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:email) }
    it { should allow_values('email@email.com').for(:email) }
  end

  describe 'When token is valid' do
    it { should validate_uniqueness_of(:token) }
  end

  describe '#generate_authentication_token!' do
    it 'generates a unique token' do
      token = 'r0lf025azsz5s51sa'   
      allow(Devise).to receive(:friendly_token).and_return(token)
      user.generate_authentication_token!
      expect(user.token).to eq token
    end

    it 'generates another token when one has been taken' do
      exists_user = FactoryBot.create(:user, token: 'r0lf025azsz5s51sa')      
      user.generate_authentication_token!
      expect(user.token).not_to eq exists_user.token
    end
  end

  describe 'associations' do
    it { should have_many(:products).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
  end
end
