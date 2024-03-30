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
      product_1 = FactoryBot.create(:product, price: 100)
      product_2 = FactoryBot.create(:product, price: 85)

      placement_1 = FactoryBot.build(:placement, product: product_1, quantity: 3)
      placement_2 = FactoryBot.build(:placement, product: product_2, quantity: 15)

      @order = FactoryBot.build(:order)

      @order.placements.push(placement_1)
      @order.placements.push(placement_2)
    end
    
    it 'returns the total amount to pay for the products' do
      expect{@order.set_total!}.to change{@order.total}.from(0).to(1575)
    end
  end

  describe '#build_placements_with_product_ids_and_quantities' do
    let!(:product1) { FactoryBot.create(:product, price: 100, quantity: 5) }
    let!(:product2) { FactoryBot.create(:product, price: 85, quantity: 10) }
    let!(:product_ids_quantities) { [[product1.id, 2], [product2.id, 3]] }

    it "builds 2 placements for the order" do
      expect {
        order.build_placements_with_product_ids_and_quantities(product_ids_quantities)
      }.to change { order.placements.size }.from(0).to(2)
    end
  end

  describe '#valid?' do 
    before(:each) do
      product_1 = FactoryBot.create(:product, price: 100, quantity: 5)
      product_2 = FactoryBot.create(:product, price: 85, quantity: 10)

      placement_1 = FactoryBot.build(:placement, product: product_1, quantity: 3)
      placement_2 = FactoryBot.build(:placement, product: product_2, quantity: 15)

      @order = FactoryBot.build(:order)

      @order.placements.push(placement_1)
      @order.placements.push(placement_2)
    end

    it "becomes invalid due to insufficient products" do
      expect(@order).to_not be_valid
    end
  end
end
