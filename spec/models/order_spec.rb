require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { FactoryBot.build(:order)}
  subject { order }

  describe 'respond to methods' do
    it { should respond_to(:user_id) }
    it { should respond_to(:total) }
    it { should respond_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:total) }    
    it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }      
  end

  describe 'associations' do    
    it { should belong_to(:user) }
    it { should have_many(:placements) }
    it { should have_many(:products).through(:placements) }
  end

  describe '#set_total!' do
    before(:each) do
      product1 = FactoryBot.create(:product, price: 100)
      product2 = FactoryBot.create(:product, price: 85)      
      @order = FactoryBot.build(:order, product_ids: [product1.id, product2.id])    
    end

    it 'returns the total amount to pay for the products' do
      expect{@order.set_total!}.to change{@order.total}.from(0).to(185)
    end
  end 
end
