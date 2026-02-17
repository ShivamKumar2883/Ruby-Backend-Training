class Product < ApplicationRecord

    has_and_belongs_to_many :stores

    # validates :title, 
    #     uniqueness: {message: 'title must be uniqueness'} , 
    #     presence: true, 
    #     length: { minimum: 5, maximum: 15}

    # validates :description, presence: true

    # validates :image_url, allow_blank: true
        # presence: true, 
        # formate:{ 
        #     with: %r{\.gif\jpg\png)\z}i, 
        #     message: 'must be a URL for GIF, JPG or PNG image.'
        # }
            
    # validates :price, 
    #     presence: true, 
    #     numericality: { greater_than_or_equal_to: 0.01 }
end
