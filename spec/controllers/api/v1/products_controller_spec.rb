require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe 'GET #show' do
    before(:each) do
      @product = FactoryBot.create(:product)
      get :show, params: { id: @product.id }
    end

    it 'returns the information about a reporter on a hash' do
      product_response = json_response
      expect(product_response[:title]).to eq @product.title
    end    

    it 'has the user as a embeded object' do
      product_response = json_response
      expect(product_response[:user][:email]).to eq @product.user.email
    end

    it { should respond_with 200 }
  end

  describe 'GET #index' do
    before(:each) do
      @product = FactoryBot.create_list(:product, 5)      
    end

    context 'When is not receiving any product_ids parameter' do
      before(:each) do
        get :index
      end

      it 'returns the list of records from the database' do
        product_response = json_response
        expect(product_response[:products].count).to eq 5
      end
  
      it 'returns the user object into each product' do
        product_response = json_response[:products]
        product_response.each do |pr|
          expect(pr[:user]).to be_present
        end
      end

      it { expect(json_response).to have_key(:meta) }
      it { expect(json_response[:meta]).to have_key(:pagination)}
      it { expect(json_response[:meta][:pagination]).to have_key(:per_page)}
      it { expect(json_response[:meta][:pagination]).to have_key(:total_pages)}
      it { expect(json_response[:meta][:pagination]).to have_key(:total_objects)}  
      it { should respond_with 200 }
    end

    context 'When product_ids parameter is sent' do
      before(:each) do
        @user = FactoryBot.create(:user)        
        FactoryBot.create_list(:product, 5, user: @user)     
        get :index, params: { product_ids: @user.product_ids }
      end

      it 'return just the product that belong to the user' do
        products_response = json_response[:products]
        products_response.each do |product_response|
          expect(product_response[:user][:email]).to eq @user.email
        end
      end

    end
    
  end

  describe 'POST #create' do
    context 'when is succesfully created' do
      before(:each) do
        user = FactoryBot.create(:user)
        @product_attributes = FactoryBot.attributes_for(:product)
        api_authorization_header user.token
        post :create, params: { user_id: user.id, product: @product_attributes }
      end     

      it 'renders the json representation for the product record just created' do
        product_response = json_response
        expect(product_response[:title]).to eq @product_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context 'when is not created' do
      before(:each) do
        user = FactoryBot.create(:user)
        @invalid_product_attributes = { title: 'Smart Tv', price: 'Twelve dollars' }
        api_authorization_header user.token
        post :create, params: { user_id: user.id, product: @invalid_product_attributes }
      end     

      it 'renders an error json' do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        product_response = json_response
        expect(product_response[:errors][:price]).to include 'is not a number'
      end

      it { should respond_with 422 }
    end
  end

  describe 'PUT/PATCH #update' do
    before(:each) do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product, user: @user)
      api_authorization_header @user.token      
    end 

    context 'when is succesfully upd ated' do
      before(:each) do        
        patch :update, params: { user_id: @user.id, id: @product.id, product: { title: 'Apple Tv'} }
      end     

      it 'renders the json representation for the updatec product' do
        product_response = json_response
        expect(product_response[:title]).to eq 'Apple Tv'
      end

      it { should respond_with 200 }
    end

    context 'when is not updated' do
      before(:each) do        
        patch :update, params: { user_id: @user.id, id: @product.id, product: { price: 'invalid param'} }
      end     

      it 'renders an error json' do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be updated' do
        product_response = json_response
        expect(product_response[:errors][:price]).to include 'is not a number'
      end

      it { should respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product, user: @user)
      api_authorization_header @user.token
      delete :destroy, params: { user_id: @user.id, id: @product.id }
    end
  end
end