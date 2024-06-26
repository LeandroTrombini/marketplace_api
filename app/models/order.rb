# frozen_string_literal: true

class Order < ApplicationRecord
  include ActiveModel::Validations

  before_validation :set_total!, if: -> { (total.nil? || total.zero?) && products.any? }
  validates :user_id, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates_with EnoughProductsValidator

  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

  def set_total!
    self.total = 0
    placements.each do |placement|
      self.total += placement.product.price * placement.quantity
    end
  end

  def build_placements_with_product_ids_and_quantities(product_ids_quantities)
    product_ids_quantities.each do |product_ids_quantitiy|
      id, quantity = product_ids_quantitiy
      placements.build(product_id: id, quantity:)
    end
  end
end
