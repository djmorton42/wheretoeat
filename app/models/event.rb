class Event < ActiveRecord::Base
    has_and_belongs_to_many :voters
    has_and_belongs_to_many :restaurants
    belongs_to :group

    def restaurant_urls
        urls = []

        restaurants.each do |r|
            urls << r.url
        end

        return urls
    end
end