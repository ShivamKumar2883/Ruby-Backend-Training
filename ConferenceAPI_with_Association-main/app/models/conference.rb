class Conference < ApplicationRecord
    belongs_to :j_user, class_name: 'JUser', foreign_key: 'j_user_id'
    
    belongs_to :badge, foreign_key: 'badges_id', class_name: 'Badge'
    belongs_to :conference_mode

    has_many :conference_categories, foreign_key: 'conferences_id'
    has_many :locations, as: :locatable, dependent: :destroy
    has_many :point_of_contacts, dependent: :destroy

    has_many :states, through: :locations
    has_many :districts, through: :locations


    # validates :conference_category_ids, presence: true
end
