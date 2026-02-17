class ConferenceCategory < ApplicationRecord

    belongs_to :conference, optional: true
end
