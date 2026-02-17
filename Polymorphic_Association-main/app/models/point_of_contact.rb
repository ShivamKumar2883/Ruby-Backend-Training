class PointOfContact < ApplicationRecord

    belongs_to :conference
    has_one :enquire, dependent: :destroy
end
