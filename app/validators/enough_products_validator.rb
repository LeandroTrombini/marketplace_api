# frozen_string_literal: true
class EnoughProductsValidator < ActiveModel::Validator
  def validate(record)
    record.placements.each do |placement|
      product = placement.product
      if placement.quantity > product.quantity
        message = "The quantity for #{product.title} is not available"
        record.errors[product.title.to_s] << message
      end
    end
  end
end
