class Conference < ApplicationRecord
    belongs_to :j_user

    has_many :conference_categories, dependent: :destroy
    has_one :bagdes, dependent: :destroy
    has_one :conference_mode
    has_many :locations, dependent: :destroy
    has_many :point_of_contacts, dependent: :destroy
end
