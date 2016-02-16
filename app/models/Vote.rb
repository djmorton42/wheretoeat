class Vote < ActiveRecord::Base
    attr_accessor :startDateTime
    attr_accessor :endDateTime
    attr_accessor :description
    attr_accessor :eventDateTime
end