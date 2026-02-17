class Conference < ApplicationRecord
    belongs_to :j_user
    
    belongs_to :badges
    belongs_to :conference_mode

    has_many :conference_categories, dependent: :destroy
    has_many :locations, as: :locatable
    has_many :point_of_contacts, dependent: :destroy

    has_many :states, through: :locations
    has_many :districts, through: :locations
end
