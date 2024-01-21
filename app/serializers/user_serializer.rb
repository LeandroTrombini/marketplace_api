class UserSerializer < ActiveModel::Serializer  
  attributes :id, :token, :email, :created_at, :updated_at, :product_ids
  has_many :products, embed: :id
end
