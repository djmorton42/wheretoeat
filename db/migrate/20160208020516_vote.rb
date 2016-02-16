class Vote < ActiveRecord::Migration
    def change
        create_table :votes do |t|
            t.integer :rank, :null => false
            t.timestamps
        end

        add_reference :votes, :voters, index: true
        add_reference :votes, :events, index: true
        add_reference :votes, :restaurants, index: true

        add_foreign_key :votes, :voters
        add_foreign_key :votes, :events
        add_foreign_key :votes, :restaurants
    end
end
