class Voter < ActiveRecord::Base
    has_one :group
    has_and_belongs_to_many :events
end