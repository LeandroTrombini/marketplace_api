class OrderProductSerializer < ActiveModel::Serializer
  def include_user?
    false
    #object.user_id == current_user.id
  end
end
