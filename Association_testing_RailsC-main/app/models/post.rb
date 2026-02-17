class Post < ApplicationRecord
    belongs_to :j_user, class_name: 'JUser', foreign_key: 'j_user_id'
    has_one :location, as: :locatable
end
