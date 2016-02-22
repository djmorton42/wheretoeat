class Voter < ActiveRecord::Migration
  def change
        create_table :voters do |t|
            t.string :email, :null => false
            t.timestamps
        end

        add_index :voters, :email, unique: true

  end
end
