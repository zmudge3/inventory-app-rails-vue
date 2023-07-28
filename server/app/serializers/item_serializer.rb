class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :quantity
end
