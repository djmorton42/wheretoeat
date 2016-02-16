class Event < ActiveRecord::Base
    has_and_belongs_to_many :voters
    has_and_belongs_to_many :restaurants
end