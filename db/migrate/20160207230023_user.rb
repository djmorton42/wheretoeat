class User < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :email, :null => false
            t.string :password_hash, :null => false
            t.string :salt, :null => false
            t.boolean :is_active, :null => false
            t.datetime :last_login
            t.timestamps
        end

        add_index :users, :email, unique: true
    end
end
