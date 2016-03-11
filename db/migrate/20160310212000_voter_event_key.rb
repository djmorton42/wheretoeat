class VoterEventKey < ActiveRecord::Migration
    def change
        create_table :voter_event_keys do |t|
            t.string :key, :null => false
            t.timestamps
        end

        add_reference :voter_event_keys, :voter, index: true
        add_reference :voter_event_keys, :event, index: true

        add_foreign_key :voter_event_keys, :voter
        add_foreign_key :voter_event_keys, :event
    end
end
