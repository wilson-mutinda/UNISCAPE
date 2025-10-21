class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone, :slug
end
