class ContainerSerializer
  include JSONAPI::Serializer
  attributes :name, :items
end
