class Location <ApplicationRecord
    belongs_to :conference

    belongs_to :state, dependent: :destroy
    belongs_to :district, dependent: :destroy
end
