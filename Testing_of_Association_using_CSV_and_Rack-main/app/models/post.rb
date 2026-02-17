class Post < ApplicationRecord
    belongs_to :j_user, class_name: 'JUser', foreign_key: 'user_id'
end
