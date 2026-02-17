class ConferenceMode < ApplicationRecord

    belongs_to :conference,  optional: true
end
