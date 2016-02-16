class Voter < ActiveRecord::Migration
  def change
        create_table :voters do |t|
            t.string :email, :null => false
            t.timestamps
        end

        add_reference :voters, :groups, index: true
        add_foreign_key :voters, :groups

  end
end
