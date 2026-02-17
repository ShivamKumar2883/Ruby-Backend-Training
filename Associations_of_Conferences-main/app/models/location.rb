class Location <ApplicationRecord
    belongs_to :conference

    has_one :state, dependent: :destroy
    has_one :district, dependent: :destroy
end
