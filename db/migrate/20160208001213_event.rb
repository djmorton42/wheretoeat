class Event < ActiveRecord::Migration
    def change
        create_table :events do |t|
            t.string :title, :null => false
            t.text :description
            t.datetime :event_date, :null => false
            t.datetime :voting_start_datetime, :null => false
            t.datetime :voting_end_datetime, :null => false
        end
    end
end
