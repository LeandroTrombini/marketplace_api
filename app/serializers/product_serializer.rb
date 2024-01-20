class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :description, :published, :created_at, :updated_at
  has_one :user
end
