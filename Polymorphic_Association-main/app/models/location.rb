class Location <ApplicationRecord
    belongs_to :locatable, polymorphic: true

    belongs_to :state
    belongs_to :district
end
