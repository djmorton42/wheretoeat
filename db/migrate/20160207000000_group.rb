class Group < ActiveRecord::Migration
def change
        create_table :groups do |t|
            t.string :name, :null => false
            t.timestamps
        end

        add_reference :groups, :user, index: true
        add_foreign_key :groups, :user
    end
end
