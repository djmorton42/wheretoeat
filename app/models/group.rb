 class Group < ActiveRecord::Base
    #attr_accessor :name
    has_many :restaurants, dependent: :destroy
    has_one :user
#    has_many :voters, dependent: :destroy
end