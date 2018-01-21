class LocationSerializer < ActiveModel::Serializer
  attributes :id , :lat , :lng 
  has_one :message, serializer: MessageSerializer
end
