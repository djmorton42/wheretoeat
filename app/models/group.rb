 class Group < ActiveRecord::Base
    #attr_accessor :name
    has_many :restaurants, dependent: :destroy
    belongs_to :user
    has_many :events, dependent: :destroy
#    has_many :voters, dependent: :destroy
end