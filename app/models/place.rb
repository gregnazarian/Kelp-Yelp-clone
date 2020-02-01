class Place < ApplicationRecord

    belongs_to :user
    has_many :comments

    geocoded_by :address
    after_validation :geocode

    validates :name, presence: true
    validates :address, presence: true
    validates :description, presence: true


    # def average_rating
    #     ratings = self.comments
    #   average = 0 
    #   ratings.each do |rate|
    #       average += rate.rating
    #   end
    #  average = average/ ratings.count   
    # end

end
