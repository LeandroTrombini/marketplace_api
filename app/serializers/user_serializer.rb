class UserSerializer < ActiveModel::Serializer
  attributes :id, :token, :email, :created_at, :updated_at
end
