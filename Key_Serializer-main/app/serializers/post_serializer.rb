class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :posted_by, :created_at, :updated_at
  belongs_to :j_user, key: :posted_by, serializer: UserSerializer

end

 