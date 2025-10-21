class StudentSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :slug

  belongs_to :user
  belongs_to :country
end
