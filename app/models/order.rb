# frozen_string_literal: true

class Order < ApplicationRecord
  before_validation :set_total!, if: -> { (total.nil? || total.zero?) && products.any? }
  validates :user_id, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
  has_many :placements
  has_many :products, through: :placements  

  def set_total!
    self.total = products.map(&:price).sum
  end
end
