
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :posted_by, :created_at, :updated_at
end

# Sir to show sample of AMS Serializer index function are implemented by AMS
# and Show using RABL 