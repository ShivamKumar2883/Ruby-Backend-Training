class District < ApplicationRecord

    has_many :location
    has_many :conferences, through: :location
end
