class Restaurant < ActiveRecord::Migration
    def change
        create_table :restaurants do |t|
            t.string :name, :null => false
            t.string :address
            t.integer :victory_count, :null => false
            t.timestamps
        end

        add_reference :restaurants, :group, index: true
        add_foreign_key :restaurants, :group
    end
end
