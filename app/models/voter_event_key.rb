class VoterEventKey < ActiveRecord::Base
    belongs_to :event
    belongs_to :voter
end