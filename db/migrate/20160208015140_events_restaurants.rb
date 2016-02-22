class EventsRestaurants < ActiveRecord::Migration
    def change

        create_join_table :events, :restaurants do |t|
          t.index :event_id
          t.index :restaurant_id
        end

        #create_table :restaurants_events do |t|
        #    t.belongs_to :restaurant, index: true
        #    t.belongs_to :event, index: true
        #end

        #add_reference :restaurant_event, :restaurant, index: true
        #add_reference :restaurant_event, :event, index: true

        #add_foreign_key :restaurant_event, :restaurant
        #add_foreign_key :restaurant_event, :event
    end
end
