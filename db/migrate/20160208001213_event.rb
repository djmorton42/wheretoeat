class Event < ActiveRecord::Migration
    def change
        create_table :events do |t|
            t.string :title, :null => false
            t.text :description
            t.datetime :event_datetime, :null => false
            t.datetime :voting_start_datetime, :null => false
            t.datetime :voting_end_datetime, :null => false
        end

        add_reference :events, :group, index: true
        add_foreign_key :events, :group
    end
end
