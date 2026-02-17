class ConferenceCategory < ApplicationRecord

    belongs_to :conference, foreign_key: 'conferences_id'
end