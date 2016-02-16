class VotersEvents < ActiveRecord::Migration
    def change
        create_table :voters_events do |t|
            t.belongs_to :voter, index: true
            t.belongs_to :event, index: true
        end

        #add_reference :voter_event, :voter, index: true
        #add_reference :voter_event, :event, index: true

        #add_foreign_key :voter_event, :voter
        #add_foreign_key :voter_event, :event
    end
end
