class Restaurant < ActiveRecord::Base
    validates :name, presence: true
    has_one :group
    has_and_belongs_to_many :events
end