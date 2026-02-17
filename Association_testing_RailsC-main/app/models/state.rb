class State < ApplicationRecord

    has_many :location
    has_many :conference, through: :location

end
